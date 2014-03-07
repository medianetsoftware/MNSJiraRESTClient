//
//  MNSProjectRestClientTests.m
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

@interface MNSProjectRestClientTests : XCTestCase {
    MNSJiraRESTClient *_jiraRestClient;
}
@end

@implementation MNSProjectRestClientTests

- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetProjectWithKey
{
    NSString *projectKey = kProjectKey;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSProject *projectDto;
    [_jiraRestClient.projectRestClient getProjectWithKey:projectKey
												 Success:^(MNSProject *aProjectDto) {
													 projectDto = aProjectDto;
													 dispatch_semaphore_signal(semaphore);
												 }fail:^(NSError *error) {
													 dispatch_semaphore_signal(semaphore);
													 XCTFail(@"Error: %@", error.localizedDescription);
												 }];
	
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(projectDto, @"projectDto is nil!");
}

- (void)testGetProjectByURL
{
    NSString *projectURL = kProjectURL;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSProject *projectDto;
    [_jiraRestClient.projectRestClient getProjectWithUrl:projectURL
                                                 Success:^(MNSProject *aProjectDto) {
                                                     projectDto = aProjectDto;
                                                     dispatch_semaphore_signal(semaphore);
                                                 }fail:^(NSError *error) {
                                                     dispatch_semaphore_signal(semaphore);
                                                     XCTFail(@"Error: %@", error.localizedDescription);
                                                 }];
	
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(projectDto, @"projectDto is nil!");
}

- (void)testGetAllProjects
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSArray *projects;
    [_jiraRestClient.projectRestClient getAllProjectsSuccess:^(NSArray *aProjects) {
		projects = aProjects;
		dispatch_semaphore_signal(semaphore);
	}fail:^(NSError *error) {
		dispatch_semaphore_signal(semaphore);
		XCTFail(@"Error: %@", error.localizedDescription);
	}];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(projects, @"projectDto is nil!");
}

@end
