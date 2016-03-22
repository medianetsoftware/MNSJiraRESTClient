//
//  MNSComponentRestClientTest.m
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
#import "MNSComponent.h"

@interface MNSComponentRestClientTests : XCTestCase{
    MNSJiraRESTClient *_jiraRestClient;
}
@end

@implementation MNSComponentRestClientTests

- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
	
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetComponentByURL
{
	
    NSString *projectURL = kComponentURL;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSComponent *componentDto;
    [_jiraRestClient.componentRestClient getComponentByUrl:projectURL
												   Success:^(MNSComponent *acomponent) {
													   componentDto = acomponent;
													   dispatch_semaphore_signal(semaphore);
												   }fail:^(NSError *error) {
													   dispatch_semaphore_signal(semaphore);
													   XCTFail(@"Error: %@", error.localizedDescription);
												   }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(componentDto, @"componentDTO is nil!");
}

- (void)testCreateComponent
{
    
    MNSComponentInput *componentInput = [[MNSComponentInput alloc] initWithName:kComponentName1 description:nil leadUsername:kComponentLeadUsername assigneetype:PROJECT_DEFAULT];
    
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSComponent *componentDto;
    
    [_jiraRestClient.componentRestClient createComponentWithProjectKey:kProjectKey componentInput:componentInput success:^(MNSComponent *acomponent) {
        componentDto = acomponent;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(componentDto, @"componentDTO is nil!");
}

- (void)testUpdateComponent
{
	
    MNSComponentInput *componentInput = [[MNSComponentInput alloc] initWithName:kComponentName2 description:nil leadUsername:kComponentLeadUsername assigneetype:PROJECT_LEAD];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSComponent *componentDto;
    
    [_jiraRestClient.componentRestClient updateComponent:kUpdateComponentURL componentInput:componentInput success:^(MNSComponent *component) {
        componentDto = component;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
	}];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(componentDto, @"componentDTO is nil!");
}

- (void)testRemoveComponent
{
	
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [_jiraRestClient.componentRestClient removeComponent:kRemoveComponentURL moveIssueToComponentUrl:nil success:^(id response) {
        
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

- (void)testRelatedIssueCounts{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block NSNumber *number;
    
    [_jiraRestClient.componentRestClient getComponentRelatedIssuesCount:getComponentRelatedIssuesCount success:^(NSNumber *issuesCount) {
        
        number = issuesCount;
        dispatch_semaphore_signal(semaphore);
		
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(number, @"number is nil!");
	
    
}








@end
