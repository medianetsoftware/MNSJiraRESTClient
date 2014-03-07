//
//  MNSJiraRESTClient.m
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
#import "MNSJiraRESTClient.h"

@implementation MNSJiraRESTClient

- (id)initWithBaseURLString:(NSString *)serverUri authenticator:(MNSRequestAuthenticator *)autheticator {
	self = [super init];
	if (self) {
		NSString *baseUri = [NSString stringWithFormat:@"%@%@", serverUri, @"/rest/api/latest"];


		_searchRestClient = [[MNSSearchRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_componentRestClient = [[MNSComponentRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_projectRestClient = [[MNSProjectRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_userRestClient = [[MNSUserRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_versionRestClient = [[MNSVersionRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_projectRolesRestClient = [[MNSProjectRolesRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
		_sessionRestClient = [[MNSSessionRestClient alloc] initWithBaseUri:serverUri authenticator:autheticator];
		_metaDataRestClient = [[MNSMetadataRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator];
        _issueRestClient = [[MNSIssueRestClient alloc] initWithBaseUri:baseUri authenticator:autheticator sessionRestClient:_sessionRestClient metadataRestClient:_metaDataRestClient];
	}
	return self;
}

@end
