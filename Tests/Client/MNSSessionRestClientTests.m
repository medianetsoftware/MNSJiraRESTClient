//
//  MNSSessionRestClientTests.m
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
#import "MNSSession.h"


@interface MNSSessionRestClientTests : XCTestCase
{
    MNSJiraRESTClient *_jiraRestClient;
}

@end

@implementation MNSSessionRestClientTests

- (void)setUp
{
    [super setUp];
    
    _jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSession
{
	
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSSession *sessionDto;
    
    [_jiraRestClient.sessionRestClient getCurrentSessionSuccess:^(MNSSession *session) {
        sessionDto = session;
        dispatch_semaphore_signal(semaphore);
    } fail:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
        XCTFail(@"Error: %@", error.localizedDescription);
    }];
	
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(sessionDto, @"issue is nil!");
}

@end
