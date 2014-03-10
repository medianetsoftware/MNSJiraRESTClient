//
//  MNSIssueRestClient.h
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
#import "MNSIssueInput.h"
#import "MNSGetCreateIssueMetadataOptions.h"
#import "MNSServerInfo.h"
#import "MNSIssue.h"

#import "MNSSessionRestClient.h"
#import "MNSMetadataRestClient.h"

typedef void (^MNSIssueClientGetIssueBlock)(MNSIssue *issue);
typedef void (^MNSIssueClientGetIssuesBlock)(NSArray *issues);
typedef void (^ServerInfoIssueRestClientSuccessBlock)(MNSServerInfo *serverinfo);


@interface MNSIssueRestClient : MNSGenericRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)authenticator sessionRestClient:(MNSSessionRestClient*)sessionrestClient metadataRestClient:(MNSMetadataRestClient*)metadataRestClient;

- (void)createIssue:(MNSIssueInput *)issueInput success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)getCreateIssueMetadataWithOptions:(MNSGetCreateIssueMetadataOptions *)options success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;



- (void)getIssue:(NSString *)issueKey success:(MNSIssueClientGetIssueBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)getIssue:(NSString *)issueKey withExpands:(NSArray *)expands success:(MNSIssueClientGetIssueBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)getIssues:(NSArray *)issueKey success:(MNSIssueClientGetIssuesBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)getVersionInfoSuccess:(ServerInfoIssueRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;


@end
