//
//  MNSIssueRestClientTests.m
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
#import "MNSIssueInput.h"


@interface MNSIssueRestClientTests : XCTestCase {
    MNSJiraRESTClient *_jiraRestClient;
}

@end

@implementation MNSIssueRestClientTests


- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetIssue
{
    NSString *issueKey = kGetIssueKey;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSIssue *issue;
    [_jiraRestClient.issueRestClient getIssue:issueKey
									  success:^(MNSIssue *anIssue) {
										  issue = anIssue;
										  
										  dispatch_semaphore_signal(semaphore);
									  }fail:^(NSError *error) {
										  dispatch_semaphore_signal(semaphore);
										  XCTFail(@"Error: %@", error.localizedDescription);
									  }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(issue, @"issue is nil!");
}
-(void)testCreateIssue{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSObject* response = nil;
    
    [_jiraRestClient.issueRestClient createIssue:[self issueInputToTest]
                                         success:^(id anResponse) {
                                             response = anResponse;
                                             dispatch_semaphore_signal(semaphore);
										 }
                                            fail:^(NSError *error) {
                                                dispatch_semaphore_signal(semaphore);
                                                XCTFail(@"Error: %@", error.localizedDescription);
                                            }];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    XCTAssertNotNil(response, @"response is nil!");
    
}
- (void)testGetCreateIssueMetadata
{
	NSArray *issueMetadataProjectKeys = @[kIssueMetadataProjectKey1];
	MNSGetCreateIssueMetadataOptions *options = [MNSGetCreateIssueMetadataOptions createMetaDataOptionsWithProjectIds:nil projectKeys:issueMetadataProjectKeys issueTypeIds:nil issueTypeNames:nil expandos:nil];
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSDictionary *response;
    [_jiraRestClient.issueRestClient getCreateIssueMetadataWithOptions:options
                                                               success:^(id anResponse) {
                                                                   response = anResponse;
																   dispatch_semaphore_signal(semaphore);
															   }fail:^(NSError *error) {
																   dispatch_semaphore_signal(semaphore);
																   XCTFail(@"Error: %@", error.localizedDescription);
															   }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(response, @"response is nil!");
    XCTAssertTrue([response isKindOfClass:[NSDictionary class]], @"resonse is not a dictionary");
}

-(MNSIssueInput*)issueInputToTest{
    MNSBasicProject* project = [[MNSBasicProject alloc] init];
    project.key = kProjectKey;
    
    MNSIssueType* issueType = [[MNSIssueType alloc] init];
    issueType.identifier = kIssueInputTypeIdentifier;
    
    
    
    MNSIssueInput* issueInput = [MNSIssueInput createWithProject:project
                                                       issueType:issueType
                                                         summary:kIssueInputSummary];
    
    MNSBasicComponent* component =  [[MNSBasicComponent alloc] init];
    [component setName:kIssueInputComponentIdentifier];
    [issueInput setComponent:component];
    
    MNSBasicUser* nuevoAsignado = [[MNSBasicUser alloc] init];
    [nuevoAsignado setName:kIssueInputAsignee];
    [issueInput setAssignee:nuevoAsignado];
    
    [issueInput setDescription:kIssueInputDescription];
    
    MNSBasicUser* nuevoreporter = [[MNSBasicUser alloc] init];
    [nuevoreporter setName:kIssueInputReporter];
    [issueInput setReporter:nuevoreporter];
    
    
    [issueInput setDueDate:[NSDate date]];
    NSLog(@"issue JSON: %@",[issueInput dictionaryVersion]);
    
    return issueInput;
}

-(void)testIssueInputCreate{
    
    
    MNSIssueInput* issueInput = [self issueInputToTest];
    
    XCTAssertTrue(issueInput.fields.count>0, @"issueInputs not added");
    XCTAssertNotNil(issueInput, @"issue is nil!");
}

-(void)testGetVersionInfo{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSServerInfo *serverInfo;
	
    [_jiraRestClient.issueRestClient getVersionInfoSuccess:^(MNSServerInfo *aServerinfo) {
        serverInfo = aServerinfo;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(serverInfo, @"returned server info is nil");
    XCTAssertTrue([serverInfo isKindOfClass:[MNSServerInfo class]], @"returned server info is not serverinfo class");
}

@end
