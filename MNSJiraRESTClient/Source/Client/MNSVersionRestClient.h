//
//  MNSVersionRestClient.h
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
#import "MNSGenericRestClient.h"
#import "MNSVersion.h"
#import "MNSVersionInput.h"
#import "MNSVersionRelatedIssuesCount.h"
#import "MNSRequestAuthenticator.h"

typedef NS_ENUM (NSUInteger, VersionPosition) {
	FIRST,
	LAST,
	EARLIER,
	LATER
};

@interface MNSVersionRestClient : MNSGenericRestClient {
	NSString *_versionRootUrl;
}

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticator;

- (void)getVersionWithUrl:(NSString *)versionUrl Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)createVersion:(MNSVersionInput *)versionInput Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)updateVersion:(NSString *)versionUrl versionInput:(MNSVersionInput *)versionInput Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)removeVersion:(NSString *)versionUrl urlmoveFixIssuesToVersionUri:(NSString *)moveFixIssuesToVersionUri urlmoveAffectedIssuesToVersionUri:(NSString *)moveAffectedIssuesToVersionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)getVersionRelatedIssuesCount:(NSString *)versionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)getNumUnresolvedIssues:(NSString *)versionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)moveVersionAfter:(NSString *)versionUrl afterVersionUrl:(NSString *)afterVersionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)moveVersion:(NSString *)versionUrl position:(VersionPosition)versionPosition Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (NSString *)getMoveVersionUri:(NSString *)versionUrl;


@end
