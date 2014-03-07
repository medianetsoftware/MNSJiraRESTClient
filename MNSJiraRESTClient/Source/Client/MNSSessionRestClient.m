//
//  MNSSessionRestClient.m
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
//  along with MNSJiraRESTClient.  If not, see <http://www.gnu.org/licenses/>./

#import "MNSSessionRestClient.h"
#import "MNSSessionBuilder.h"
#import "MNSSession.h"

@implementation MNSSessionRestClient


- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticato {
	self = [super initWithBaseUri:baseUri authenticator:autheticato];
	if (self) {
	}
	return self;
}


- (void)getCurrentSessionSuccess:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    [self getUrl:[NSString stringWithFormat:@"%@/rest/auth/latest/session",self.baseUri] success:^(NSDictionary *response) {
        if (success) {
            NSError* error;

            MNSSession *session = [MNSSessionBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(session);
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
