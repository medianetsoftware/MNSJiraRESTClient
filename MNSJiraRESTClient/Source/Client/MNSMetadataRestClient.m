//
//  MNSMetadataRestClient.m
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
#import "MNSMetadataRestClient.h"
#import "MNSIssueType.h"
#import "MNSIssueTypeBuilder.h"
#import "MNSIssueLinksTypeBuilder.h"
#import "MNSStatusBuilder.h"
#import "MNSPriorityBuilder.h"
#import "MNSResolutionBuilder.h"
#import "MNSServerInfoBuilder.h"
#import "MNSFieldBuilder.h"
#import "MNSStatus.h"
#import "MNSPriority.h"
#import "MNSResolution.h"
#import "MNSServerInfo.h"

static NSString *const kIssueTypeParameter = @"/issuetype";
static NSString *const kIssueLinkTypeParameter = @"/issueLinkType";
static NSString *const kPriorityParameter = @"/priority";
static NSString *const kResolutionParameter = @"/resolution";
static NSString *const kFieldParameter = @"/field";
static NSString *const kServerInfoResourcePath = @"/serverInfo";

@implementation MNSMetadataRestClient

-(id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator*)authenticator {
    self = [super initWithBaseUri:baseUri authenticator:authenticator];
    if (self){

    }
    return self;
}

-(void)getIssueType:(NSString *)url success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
   
    [self getUrl:url
         success:^(NSDictionary *response) {
             NSError* error;
             MNSIssueType *issueType = [MNSIssueTypeBuilder buildWithJSONObject:response error:&error];
             if (success && [error.domain length] == 0) {
                 success(issueType);
             }
             else{
                 if(fail)
                     fail(error);
             }
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];

}

-(void)getIssueTypesSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kIssueTypeParameter]
         success:^(NSArray *response) {
             
             NSMutableArray *issueTypes = [[NSMutableArray alloc] init];
             NSError* error;
             for (int i = 0;i<[response count];i++){
                 [issueTypes addObject:[MNSIssueTypeBuilder buildWithJSONObject:[response objectAtIndex:i] error:&error]];
                 
             }
             if (success && [error.domain length] == 0) {
                 success(issueTypes);
             }
             else{
                 if(fail)
                     fail(error);
             }
             
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
}

-(void)getIssueLinkTypesSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kIssueLinkTypeParameter]
         success:^(NSDictionary *response) {
             NSMutableArray *issueLinkTypes = [[NSMutableArray alloc] init];
             NSError* error;

             for (int i = 0;i<[[response objectForKey:@"issueLinkTypes"]count];i++){

                 [issueLinkTypes addObject:[MNSIssueLinksTypeBuilder buildWithJSONObject:[[response objectForKey:@"issueLinkTypes"] objectAtIndex:i] error:&error]];
             }
             
             if (success && [error.domain length] == 0) {
                 success(issueLinkTypes);
             }
             else{
                 if(fail)
                     fail(error);
             }

         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
    
}


-(void)getStatus:(NSString *)url success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:url
         success:^(NSDictionary *response) {
             NSError* error;
             
             MNSStatus *status = [MNSStatusBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(status);
             }
             else{
                 if(fail)
                     fail(error);
             }


             
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];

}

-(void)getPriority:(NSString *)url success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:url
         success:^(NSDictionary *response) {
             NSError* error;
             
             MNSPriority* priority = [MNSPriorityBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(priority);
             }
             else{
                 if(fail)
                     fail(error);
             }

    
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];

}

-(void)getPrioritiesSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kPriorityParameter]
         success:^(NSArray *response) {
             NSMutableArray *priorityArray = [[NSMutableArray alloc] init];
             NSError* error;

             for (int i = 0;i<[response count];i++){

                 [priorityArray addObject:[MNSPriorityBuilder buildWithJSONObject:[response objectAtIndex:i] error:&error]];
             }
             
             if (success && [error.domain length] == 0) {
                 success(priorityArray);
             }
             else{
                 if(fail)
                     fail(error);
             }
            
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
    
}

-(void)getResolution:(NSString *)url success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:url
         success:^(NSDictionary *response) {
             NSError* error;
             
             MNSResolution *resolution = [MNSResolutionBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(resolution);
             }
             else{
                 if(fail)
                     fail(error);
             }
             
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];}

-(void)getResolutionsSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kResolutionParameter]
         success:^(NSArray *response) {
             NSMutableArray *resoltionArray = [[NSMutableArray alloc] init];
             NSError* error;

             for (int i = 0;i<[response count];i++){

                 [resoltionArray addObject:[MNSResolutionBuilder buildWithJSONObject:[response objectAtIndex:i] error:&error]];
             }
             
             if (success && [error.domain length] == 0) {
                 success(resoltionArray);
             }
             else{
                 if(fail)
                     fail(error);
             }
             
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
    
}

-(void)getServerInfoSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kServerInfoResourcePath]
         success:^(NSDictionary *response) {
             
             NSError*error;
             MNSServerInfo *serverInfo =  [MNSServerInfoBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(serverInfo);
             }
             else{
                 if(fail)
                     fail(error);
             }
             
             
         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
}

-(void)getFieldsSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[self.baseUri stringByAppendingString:kFieldParameter]
         success:^(NSArray *response) {
             NSMutableArray *fields = [[NSMutableArray alloc] init];
             NSError* error;

             for (int i = 0;i<[response count];i++){

                 [fields addObject:[MNSFieldBuilder buildWithJSONObject:[response objectAtIndex:i] error:&error]];
             }
             
             if (success && [error.domain length] == 0) {
                 success(fields);
             }
             else{
                 if(fail)
                     fail(error);
             }

         } fail:^(NSError *error) {
             if(fail)
                 fail(error);
         }];
}

@end
