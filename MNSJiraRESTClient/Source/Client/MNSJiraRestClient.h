//
//  MNSJiraRESTClient.h
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
#import "MNSSearchRestClient.h"
#import "MNSComponentRestClient.h"
#import "MNSProjectRestClient.h"
#import "MNSUserRestClient.h"
#import "MNSVersionRestClient.h"
#import "MNSProjectRolesRestClient.h"
#import "MNSSessionRestClient.h"
#import "MNSMetadataRestClient.h"

@interface MNSJiraRESTClient : NSObject {
}

@property (readonly, nonatomic) MNSIssueRestClient *issueRestClient;
@property (readonly, nonatomic) MNSSearchRestClient *searchRestClient;
@property (readonly, nonatomic) MNSComponentRestClient *componentRestClient;
@property (readonly, nonatomic) MNSProjectRestClient *projectRestClient;
@property (readonly, nonatomic) MNSUserRestClient *userRestClient;
@property (readonly, nonatomic) MNSVersionRestClient *versionRestClient;
@property (readonly, nonatomic) MNSProjectRolesRestClient *projectRolesRestClient;
@property (readonly, nonatomic) MNSSessionRestClient *sessionRestClient;
@property (readonly, nonatomic) MNSMetadataRestClient *metaDataRestClient;



- (id)initWithBaseURLString:(NSString *)serverUri authenticator:(MNSRequestAuthenticator *)autheticator;

@end
