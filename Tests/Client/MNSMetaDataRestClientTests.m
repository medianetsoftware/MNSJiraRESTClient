//
//  MNSMetaDataTest.m
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
#import <XCTest/XCTest.h>
#import "MNSClientsTestsConstants.h"
#import "MNSJiraRESTClientFactory.h"
#import "MNSIssueType.h"
#import "MNSStatus.h"
#import "MNSPriority.h"
#import "MNSResolution.h"
#import "MNSServerInfo.h"

@interface MNSMetaDataRestClientTests : XCTestCase
{
    MNSJiraRESTClient *_jiraRestClient;
}
@end

@implementation MNSMetaDataRestClientTests

- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
    
}


- (void)tearDown
{
    [super tearDown];
}

- (void)testGetIssueTypeByURL
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSIssueType *issueTypeDto;
    
    [_jiraRestClient.metaDataRestClient getIssueType:kMetadataIssueTypeURL success:^(MNSIssueType *issueType) {
        issueTypeDto = issueType;
        dispatch_semaphore_signal(semaphore);
    }fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(issueTypeDto, @"projectDto is nil!");
	
}

- (void)testgetIssueTypesSuccess
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSMutableArray *issueTypes;
    
    [_jiraRestClient.metaDataRestClient getIssueTypesSuccess:^(NSMutableArray *issueTypesArray) {
        issueTypes = issueTypesArray;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(issueTypes, @"staus is nil!");
    
}

- (void)testgetIssueLinkTypes
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSMutableArray *issueLinkTypes;
    
    [_jiraRestClient.metaDataRestClient getIssueLinkTypesSuccess:^(NSMutableArray *issueLinkTypesArray) {
        issueLinkTypes = issueLinkTypesArray;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(issueLinkTypes, @"issueLinkTypes is nil!");
    
}

- (void)testgetStatus
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSStatus *statusDto;
    
    [_jiraRestClient.metaDataRestClient getIssueLinkTypesSuccess:^(MNSStatus *status) {
        statusDto = status;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(statusDto, @"statusDto is nil!");
    
}

- (void)testgetPriority
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSPriority *priorityDto;
    
    [_jiraRestClient.metaDataRestClient getIssueLinkTypesSuccess:^(MNSPriority *priority) {
        priorityDto = priority;
        dispatch_semaphore_signal(semaphore);
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(priorityDto, @"priorityDto is nil!");
    
}


- (void)testgetPriorities
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSMutableArray *priorityArray;
    
    [_jiraRestClient.metaDataRestClient getPrioritiesSuccess:^(NSMutableArray *priorities) {
        priorityArray = priorities;
        dispatch_semaphore_signal(semaphore);
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(priorityArray, @"issueLinkTypes is nil!");
    
}

- (void)testgetResolution
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSResolution *resolutionDto;
    
    [_jiraRestClient.metaDataRestClient getResolution:kMetadataResolutionURL success:^(MNSResolution *resolution) {
        resolutionDto = resolution;
        dispatch_semaphore_signal(semaphore);
		
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(resolutionDto, @"priorityDto is nil!");
    
}

- (void)testgetResolutions
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSMutableArray *resolutionsArray;
    
    [_jiraRestClient.metaDataRestClient getResolutionsSuccess:^(NSMutableArray *resolutions) {
        resolutionsArray = resolutions;
        dispatch_semaphore_signal(semaphore);
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(resolutionsArray, @"issueLinkTypes is nil!");
    
}

- (void)testgetServerInfo
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSServerInfo *serverInfoDto;
    
    [_jiraRestClient.metaDataRestClient getServerInfoSuccess:^(MNSServerInfo *serverInfo) {
        serverInfoDto = serverInfo;
        dispatch_semaphore_signal(semaphore);
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(serverInfoDto, @"issueLinkTypes is nil!");
    
}

- (void)testgetFields
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSMutableArray *fieldsArray;
    
    [_jiraRestClient.metaDataRestClient getFieldsSuccess:^(NSMutableArray *fields) {
        fieldsArray = fields;
        dispatch_semaphore_signal(semaphore);
		
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(fieldsArray, @"issueLinkTypes is nil!");
    
}




@end
