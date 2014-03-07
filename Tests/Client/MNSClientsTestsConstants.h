//
//  MNSClientsTestsConstants.h
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

//Global
FOUNDATION_EXPORT NSString *const kFullURLDomain;
FOUNDATION_EXPORT NSString *const kUsername;
FOUNDATION_EXPORT NSString *const kPassword;
FOUNDATION_EXPORT NSString *const kProjectKey;

//Component:
FOUNDATION_EXPORT NSString *const kComponentURL;
FOUNDATION_EXPORT NSString *const kComponentName1;
FOUNDATION_EXPORT NSString *const kComponentLeadUsername;
FOUNDATION_EXPORT NSString *const kComponentName2;
FOUNDATION_EXPORT NSString *const kUpdateComponentURL;
FOUNDATION_EXPORT NSString *const kRemoveComponentURL;
FOUNDATION_EXPORT NSString *const getComponentRelatedIssuesCount;

//Issue:
FOUNDATION_EXPORT NSString *const kGetIssueKey;
FOUNDATION_EXPORT NSString *const kIssueMetadataProjectKey1;
FOUNDATION_EXPORT NSString *const kIssueInputTypeIdentifier;
FOUNDATION_EXPORT NSString *const kIssueInputSummary;
FOUNDATION_EXPORT NSString *const kIssueInputComponentIdentifier;
FOUNDATION_EXPORT NSString *const kIssueInputAsignee;
FOUNDATION_EXPORT NSString *const kIssueInputDescription;
FOUNDATION_EXPORT NSString *const kIssueInputReporter;

//MetaData:
FOUNDATION_EXPORT NSString *const kMetadataIssueTypeURL;
FOUNDATION_EXPORT NSString *const kMetadataResolutionURL;

//Project:
FOUNDATION_EXPORT NSString *const kProjectURL;

//Project roles:
FOUNDATION_EXPORT NSString *const kProjectRoleURL;
FOUNDATION_EXPORT NSInteger const kRoleID;

//Search:
FOUNDATION_EXPORT NSString *const kBasicJQL;
FOUNDATION_EXPORT NSString *const kComplexJQL;
FOUNDATION_EXPORT NSInteger const kSearchMaxResult;
FOUNDATION_EXPORT NSInteger const kSearchStartAt;
FOUNDATION_EXPORT long const kSearchFilter;
FOUNDATION_EXPORT NSString *const kSearchFilerURL;

//User:
FOUNDATION_EXPORT NSString *const kGetUserUsername;

//Version:
FOUNDATION_EXPORT NSString *const kVersionURL;
FOUNDATION_EXPORT NSString *const kCreateVersionDescription;
FOUNDATION_EXPORT NSString *const kCreateVersionName;
FOUNDATION_EXPORT NSString *const kUpdateVersionDescription;
FOUNDATION_EXPORT NSString *const kUpdateVersionName;
FOUNDATION_EXPORT NSString *const kUpdateVersionURL;
FOUNDATION_EXPORT NSString *const kDeleteVersionURL;
FOUNDATION_EXPORT NSString *const kVersionRelatedIssuesCountURL;
FOUNDATION_EXPORT NSString *const kNumUnresolvedIssuesURL;
FOUNDATION_EXPORT NSString *const kMoveVersionAfterURL;
FOUNDATION_EXPORT NSString *const kAfterVersionUrl;
FOUNDATION_EXPORT NSString *const kMoveVersionURL;

