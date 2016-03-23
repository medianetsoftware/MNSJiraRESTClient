//
//  MNSProjectRolesRestClient.m
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
#import "MNSProjectRolesRestClient.h"
#import "MNSProjectRoleBuilder.h"
#import "MNSProjectRole.h"
#import "MNSBasicProjectRoleBuilder.h"

static NSString *const kRoleURLPrefix = @"/role/";

@implementation MNSProjectRolesRestClient

-(void)getRoleByURLString:(NSString*)roleURLString success:(void (^)(MNSProjectRole *projectRoleDTO))success fail:(MNSRestClientFailBlock)fail {
    [self getUrl:roleURLString
         success:^(id response) {
             if (success) {
                 NSError* error;
                 
                 MNSProjectRole *projectRoleDTO = [MNSProjectRoleBuilder buildWithJSONObject:response error:&error];
                 
                 if (success && [error.domain length] == 0) {
                     success(projectRoleDTO);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}

-(void)getRoleByProjectURL:(NSString*)projectURL roleID:(NSInteger)roleID success:(void (^)(MNSProjectRole *projectRoleDTO))success fail:(MNSRestClientFailBlock)fail {
    NSString *url = [NSString stringWithFormat:@"%@%@%ld", projectURL, kRoleURLPrefix, (long)roleID];
    [self getUrl:url
         success:^(id response) {
             if (success) {
                 NSError* error;
                 
                 MNSProjectRole *projectRoleDTO = [MNSProjectRoleBuilder buildWithJSONObject:response error:&error];
                 
                 if (success && [error.domain length] == 0) {
                     success(projectRoleDTO);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}

-(void)getRolesByProjectURL:(NSString*)projectURL success:(void (^)(NSArray *projectRoles))success fail:(MNSRestClientFailBlock)fail {
    NSString *url = [NSString stringWithFormat:@"%@%@", projectURL, kRoleURLPrefix];
    [self getUrl:url
         success:^(id response) {
             if (success) {
                 NSMutableArray *projectRoles = [NSMutableArray array];
                 NSError* error;
                 
                 for (NSString *key in [response allKeys]){
                     
                     MNSBasicProjectRole *basicProjecRole = [MNSBasicProjectRoleBuilder buildWithJSONObject:response error:&error keyString:key];
                     [projectRoles addObject:basicProjecRole];
                 }
                 
                 if (success && [error.domain length] == 0) {
                     success(projectRoles);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}
@end

