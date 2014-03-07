//
//  MNSIssueRestClient.m
//
//  Copyright 2014 MediaNet Software
//  This file is part of MNSJiraRESTClient.
//
//  MNSJiraRESTClient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License.
//
//  MNSJiraRESTClient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with MNSJiraRESTClient.  If not, see <http://www.gnu.org/licenses/>.
#import "MNSIssueRestClient.h"

#import "MNSSessionRestClient.h"
#import "MNSMetadataRestClient.h"

#import "MNSIssueBuilder.h"



@interface MNSIssueRestClient () {
	MNSSessionRestClient *_sessionRestClient;
	MNSMetadataRestClient *_metadataRestClient;

	MNSServerInfo *_serverInfo;
}
@end

@implementation MNSIssueRestClient

-(id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator*)authenticator sessionRestClient:(id)sessionrestClient metadataRestClient:(id)metadataRestClient{
    self = [super initWithBaseUri:baseUri authenticator:authenticator];
    if (self){
        _sessionRestClient = sessionrestClient;
        _metadataRestClient = metadataRestClient;
    }
    return self;
}


-(void)createIssue:(MNSIssueInput *)issueInput success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    NSString* issueURL = [self.baseUri stringByAppendingString:URI_PATH_ISSUE];
    NSDictionary* body = [NSDictionary dictionaryWithObject:[issueInput dictionaryVersion]
                                                     forKey:@"fields"];
    [self postUrl:issueURL bodyJSONObject:body success:^(id response) {
        if (success) {
            success(response);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)getCreateIssueMetadataWithOptions:(MNSGetCreateIssueMetadataOptions *)options success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    NSString* issueURL = [self.baseUri stringByAppendingString:URI_PATH_ISSUE_CREATEMETA];
    if (options) {
        
        if (options.projectIds)
            [parameters setObject:[options.projectIds componentsJoinedByString:@","] forKey:@"projectIds"];
        
        if (options.projectKeys)
            [parameters setObject:[options.projectKeys componentsJoinedByString:@","] forKey:@"projectKeys"];
        
        if (options.issueTypeIds)
            [parameters setObject:[options.issueTypeIds componentsJoinedByString:@","] forKey:@"issuetypeIds"];
        
        if (options.issueTypeNames)
            [parameters setObject:[options.issueTypeNames componentsJoinedByString:@","] forKey:@"issuetypeNames"];
        
        if (options.expandos)
            [parameters setObject:[options.expandos componentsJoinedByString:@","] forKey:@"expand"];
    }
    if (parameters.count>0){
        BOOL firstParam = TRUE;
        
        for(NSString* metadataOption in [parameters allKeys]){
            issueURL = [issueURL stringByAppendingString:firstParam?@"?":@"&"];
            firstParam = FALSE;
            issueURL = [issueURL stringByAppendingFormat:@"%@=%@",metadataOption,[parameters objectForKey:metadataOption]];
        }
    }
    [self getUrl:issueURL success:^(NSDictionary *response) {
        if (success)
            success(response);
    } fail:^(NSError *error) {
        if (fail)
            fail(error);
    }];

}


-(void)getIssue:(NSString*)issueKey success:(MNSIssueClientGetIssueBlock)success fail:(MNSRestClientFailBlock)fail{
    NSArray *defaultExpands = @[@"names", @"schema", @"transitions"];
    //NSArray *allExpands = @[@"renderedFields", @"names", @"schema", @"transitions", @"operations", @"editmeta", @"changelog"];
    [self getIssue:issueKey withExpands:defaultExpands success:success fail:fail];
}

-(void)getIssue:(NSString *)issueKey withExpands:(NSArray *)expands success:(MNSIssueClientGetIssueBlock)success fail:(MNSRestClientFailBlock)fail{
    
    NSString* urlString = [self.baseUri stringByAppendingString:URI_PATH_ISSUE];
    urlString = [urlString stringByAppendingFormat:@"/%@", issueKey];
    
    NSMutableDictionary *parametersInURL;
    if (expands) {
        parametersInURL = [NSMutableDictionary dictionary];
        [parametersInURL setObject:[expands componentsJoinedByString:@","] forKey:kExpand];
    }
    
    [self getUrl:urlString
     parametersInURL:parametersInURL
         success:^(id response) {
             NSError* error;
             MNSIssue* issue = [MNSIssueBuilder buildWithJSONObject:response error:&error];

        if (success && [error.domain length] == 0) {
            success(issue);
        }
        else{
            if (fail){
                fail (error);
            }
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

-(void)getIssues:(NSArray *)issueKey success:(MNSIssueClientGetIssuesBlock)success fail:(MNSRestClientFailBlock)fail{
    NSString* url = [self.baseUri stringByAppendingString:URI_PATH_ISSUE];
    url = [url stringByAppendingFormat:@"/%@",issueKey];
    [self getUrl:url success:^(id response) {
        if (success) {
            success(response);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
}


-(void)getVersionInfoSuccess:(ServerInfoIssueRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    if(!_serverInfo)
        [_metadataRestClient getServerInfoSuccess:^(NSDictionary *response) {
            if (success){
                MNSServerInfo* serverInfo = (id)response;//TODO coger del response el serverInfo
                success(serverInfo);
            }
        } fail:^(NSError *error) {
            if (fail)
                fail(error);
        }];
    else
        success(_serverInfo);
}
@end
