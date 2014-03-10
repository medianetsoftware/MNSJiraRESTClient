//
//  MNSProjectRestClient.m
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

#import "MNSProjectRestClient.h"
#import "MNSProjectBuilder.h"

static NSString *const kProjectURLPrefix = @"project";

@implementation MNSProjectRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticato{
    self = [super initWithBaseUri:baseUri authenticator:autheticato];
    return self;
}


- (void)getProjectWithKey:(NSString*)key Success:(void(^)(MNSProject *projectDTO))success fail:(MNSRestClientFailBlock)fail{
        NSString *finalUrl = [NSString stringWithFormat:@"%@/%@/%@",self.baseUri, kProjectURLPrefix, key];
        
        [self getUrl:finalUrl success:^(id response) {
            
            NSError *error;
            MNSProject *projectDTO = (MNSProject*)[MNSProjectBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(projectDTO);
            }
            else{
                if(fail)
                    fail(error);
            }
            
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
}

- (void)getProjectWithUrl:(NSString*)url Success:(void(^)(MNSProject *projectDTO))success fail:(MNSRestClientFailBlock)fail;
{
        [self getUrl:url success:^(id response) {
            NSError* error;

            MNSProject *projectDTO = (MNSProject*)[MNSProjectBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(projectDTO);
            }
            else{
                if(fail)
                    fail(error);
            }
            
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    
}

- (void)getAllProjectsSuccess:(void(^)(NSArray *projects))success fail:(MNSRestClientFailBlock)fail{
        NSString *finalUrl = [NSString stringWithFormat:@"%@/%@",self.baseUri, kProjectURLPrefix];
        
        
        [self getUrl:finalUrl success:^(id response) {
            NSError* error;

            NSMutableArray *projectsArray = [MNSProjectBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(projectsArray);
            }
            else{
                if(fail)
                    fail(error);
            }
            
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
}


@end
