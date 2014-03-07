//
//  MNSComponentRestClient.m
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
#import "MNSComponentRestClient.h"
#import "MNSComponentInputWithProjectKey.h"
#import "MNSComponentBuilder.h"


@implementation MNSComponentRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticator{
    self = [super initWithBaseUri:baseUri authenticator:autheticator];
    if (self){
        _componentUrl = [NSString stringWithFormat:@"%@/%@",baseUri,@"component"];
    }
    return self;
}

- (void)getComponentByUrl:(NSString*)url Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:url success:^(NSDictionary *response) {
        NSError* error;
        
        MNSComponent * component =[MNSComponentBuilder buildWithJSONObject:response error:&error];
        
        if (success && [error.domain length] == 0) {
            success(component);
        }
        else{
            if (fail) {
                fail(error);
            }
        }
        
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
- (void)createComponentWithProjectKey:(NSString *)projectKey componentInput:(MNSComponentInput*)componentInput success:(MNSRestClientSuccessBlock)success fail:
(MNSRestClientFailBlock)fail{
    
    MNSComponentInputWithProjectKey *helper = [[MNSComponentInputWithProjectKey alloc]initWithProjectKey:projectKey componentType:componentInput];
    
    [self postUrl:_componentUrl bodyJSONObject:[helper dicToSend] success:^(NSDictionary *response) {
        NSError* error;
        
        MNSComponent * component =[MNSComponentBuilder buildWithJSONObject:response error:&error];
        
        if (success && [error.domain length] == 0) {
            success(component);
        }
        else{
            if (fail) {
                fail(error);
            }
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
}


- (void)updateComponent:(NSString*)componentUrl componentInput:(MNSComponentInput*)componentInput success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    MNSComponentInputWithProjectKey *helper = [[MNSComponentInputWithProjectKey alloc]initWithProjectKey:nil componentType:componentInput];
    
    [self putUrl:componentUrl bodyJSONObject:[helper dicToSend] success:^(NSDictionary *response) {
        NSError* error;
        
        MNSComponent * component =[MNSComponentBuilder buildWithJSONObject:response error:&error];
        
        if (success && [error.domain length] == 0) {
            success(component);
        }
        else{
            if (fail) {
                fail(error);
            }
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
}

- (void)removeComponent:(NSString *)componentUrl moveIssueToComponentUrl:(NSString*)moveIssueToComponentUri success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    
    NSString *finalUrl;
    if (moveIssueToComponentUri){
        finalUrl = [NSString stringWithFormat:@"%@?moveIssuesTo=%@",componentUrl,moveIssueToComponentUri];
    }
    else
        finalUrl = componentUrl;
    
    [self deleteUrl:finalUrl success:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

- (void)getComponentRelatedIssuesCount:(NSString *)componentUrl success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    NSString *finalUrl = [NSString stringWithFormat:@"%@/relatedIssueCounts",componentUrl];
    [self getUrl:finalUrl success:^(NSDictionary *response) {
        if (success) {
            success([response objectForKey:@"issueCount"]);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
}
@end
