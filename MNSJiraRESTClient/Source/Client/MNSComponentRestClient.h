//
//  MNSComponentRestClient.h
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
#import <Foundation/Foundation.h>
#import "MNSComponent.h"
#import "MNSComponentInput.h"
#import "MNSGenericRestClient.h"
#import "MNSRequestAuthenticator.h"


@interface MNSComponentRestClient : MNSGenericRestClient {
	NSString *_componentUrl;
}

- (void)getComponentByUrl:(NSString *)url Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)createComponentWithProjectKey:(NSString *)projectKey componentInput:(MNSComponentInput *)componentInput success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)updateComponent:(NSString *)componentUrl componentInput:(MNSComponentInput *)componentInput success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)removeComponent:(NSString *)componentUrl moveIssueToComponentUrl:(NSString *)moveIssueToComponentUri success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)getComponentRelatedIssuesCount:(NSString *)componentUrl success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;




@end
