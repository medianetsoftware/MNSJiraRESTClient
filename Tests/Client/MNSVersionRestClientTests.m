//
//  MNSVersionRestClientTests.m
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
#import "MNSJiraRESTClientFactory.h"
#import "MNSClientsTestsConstants.h"


@interface MNSVersionRestClientTests : XCTestCase
{
    MNSJiraRESTClient *_jiraRestClient;
}
@end

@implementation MNSVersionRestClientTests

- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetVersionByURL
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersion *versionDto;
    
    [_jiraRestClient.versionRestClient getVersionWithUrl:kVersionURL Success:^(MNSVersion *version) {
        versionDto = version;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
	
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionDto, @"versionDTO is nil!");
}

- (void)testCreateVersion
{
    
    MNSVersionInput *versionInput = [[MNSVersionInput alloc] initWithProjectKey:kProjectKey description:kCreateVersionDescription name:kCreateVersionName isArchived:NO isReleased:YES releaseDate:[NSDate date]];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersion *versionDto;
    
    [_jiraRestClient.versionRestClient createVersion:versionInput Success:^(MNSVersion *version) {
        versionDto = version;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
	
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionDto, @"versionDTO is nil!");
}

- (void)testUpdateVersion
{
    
    MNSVersionInput *versionInput = [[MNSVersionInput alloc] initWithProjectKey:kProjectKey description:kUpdateVersionDescription name:kUpdateVersionName isArchived:NO isReleased:YES releaseDate:[NSDate date]];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersion *versionDto;
    
    [_jiraRestClient.versionRestClient updateVersion:kUpdateVersionURL versionInput:versionInput Success:^(MNSVersion *version) {
        versionDto = version;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionDto, @"versionDTO is nil!");
}

- (void)testDeleteVersion
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
    [_jiraRestClient.versionRestClient removeVersion:kDeleteVersionURL urlmoveFixIssuesToVersionUri:nil urlmoveAffectedIssuesToVersionUri:nil Success:^(id response) {
        
        BOOL correct = YES;
        XCTAssertTrue(correct, @"remove correct!!");
        
        dispatch_semaphore_signal(semaphore);
        
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
}


- (void)testRelatedIssuesCount{
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersionRelatedIssuesCount *versionIssues;
    
    [_jiraRestClient.versionRestClient getVersionRelatedIssuesCount:kVersionRelatedIssuesCountURL Success:^(MNSVersionRelatedIssuesCount * versionRelatedIssuesCount) {
        
        versionIssues = versionRelatedIssuesCount;
        dispatch_semaphore_signal(semaphore);
        
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionIssues, @"versionDTO is nil!");
}


- (void)testNumUnresolvedIssues{
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block id versionIssues;
    
    [_jiraRestClient.versionRestClient getNumUnresolvedIssues:kNumUnresolvedIssuesURL Success:^(id numUnresolvedIssues) {
        versionIssues = numUnresolvedIssues;
        dispatch_semaphore_signal(semaphore);
        
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionIssues, @"versionDTO is nil!");
}


- (void)testMoveVersionAfter
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersion *versionDto;
    
    [_jiraRestClient.versionRestClient moveVersionAfter:kMoveVersionAfterURL afterVersionUrl:kAfterVersionUrl Success:^(MNSVersion *version) {
        versionDto = version;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionDto, @"versionDTO is nil!");
}

- (void)testMoveVersion
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSVersion *versionDto;
    
    [_jiraRestClient.versionRestClient moveVersion:kMoveVersionURL position:FIRST Success:^(MNSVersion *version) {
        versionDto = version;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(versionDto, @"versionDTO is nil!");
}


@end
