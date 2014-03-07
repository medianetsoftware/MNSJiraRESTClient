//
//  MNSUserRestClient.m
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
#import "MNSUserRestClient.h"
#import "MNSUserBuilder.h"

static NSString *const kUserURLPrefix = @"/user";
static NSString *const kUsernameAttribute = @"username";
static NSString *const kExpandAttribute = @"expand";

@implementation MNSUserRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)authenticator {
	self = [super initWithBaseUri:baseUri authenticator:authenticator];
	if (self) {
		_userURLString = [baseUri stringByAppendingString:kUserURLPrefix];
	}
	return self;
}

- (void)getUserByEmail:(NSString *)email success:(void (^)(MNSUser *userDTO))success fail:(MNSRestClientFailBlock)fail {
	[self getUserByUsername:email success:success fail:fail];
}

- (void)getUserByUsername:(NSString*)username success:(void (^)(MNSUser *userDTO))success fail:(MNSRestClientFailBlock)fail {
    NSMutableDictionary *parametersInURL = [NSMutableDictionary dictionary];
    [parametersInURL setObject:username forKey:kUsernameAttribute];
    
    NSArray *expandosValues = [NSArray arrayWithObjects:@"groups", nil];
    [parametersInURL setObject:[expandosValues componentsJoinedByString:@","] forKey:kExpandAttribute];
    
    [self getUrl:_userURLString
 parametersInURL:parametersInURL
         success:^(id response) {
             
             NSError* error;
             
             MNSUser *userDTO = [MNSUserBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(userDTO);
             }
             else{
                 if(fail)
                     fail(error);
             }
         }
            fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
}

- (void)getUserByURLString:(NSString*)urlString success:(void (^)(MNSUser *userDTO))success fail:(MNSRestClientFailBlock)fail {
    [self getUrl:urlString
         success:^(id response) {
             NSError* error;
             
             MNSUser *userDTO = [MNSUserBuilder buildWithJSONObject:response error:&error];
             
             if (success && [error.domain length] == 0) {
                 success(userDTO);
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
