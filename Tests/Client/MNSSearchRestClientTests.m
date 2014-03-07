//
//  MNSSearchRestClientTests.m
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

@interface MNSSearchRestClientTests : XCTestCase {
    MNSJiraRESTClient *_jiraRestClient;
}

@end

@implementation MNSSearchRestClientTests

- (void)setUp
{
    [super setUp];
    
	_jiraRestClient = [MNSJiraRESTClientFactory jiraRestClientAuthenticatedWithURLString:kFullURLDomain username:kUsername password:kPassword];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBasicSearchJQL
{
    NSString *jql = kBasicJQL;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSSearchResult *searchResultDTO;
    [_jiraRestClient.searchRestClient searchJQL:jql
										success:^(MNSSearchResult *aSearchResultDTO) {
											searchResultDTO = aSearchResultDTO;
											dispatch_semaphore_signal(semaphore);
										}fail:^(NSError *error) {
											dispatch_semaphore_signal(semaphore);
											XCTFail(@"Error: %@", error.localizedDescription);
										}];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(searchResultDTO, @"searchResultDTO is nil!");
}

- (void)testComplexSearchJQL
{
    NSString *jql = kComplexJQL;
    NSInteger maxResult = kSearchMaxResult;
    NSInteger startAt = kSearchStartAt;
    NSArray *fields = [NSArray arrayWithObjects:@"id", @"key", nil];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSSearchResult *searchResultDTO;
    [_jiraRestClient.searchRestClient searchJQL:jql
                                     maxResults:maxResult
                                        startAt:startAt
                                         fields:fields
                                        success:^(MNSSearchResult *aSearchResultDTO) {
                                            searchResultDTO = aSearchResultDTO;
                                            dispatch_semaphore_signal(semaphore);
                                        }fail:^(NSError *error) {
                                            dispatch_semaphore_signal(semaphore);
                                            XCTFail(@"Error: %@", error.localizedDescription);
                                        }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(searchResultDTO, @"searchResultDTO is nil!");
}

- (void)testFilterByID
{
    long filter = kSearchFilter;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSFilter *filterDTO;
    [_jiraRestClient.searchRestClient getFilterByID:filter
											success:^(MNSFilter *aFilterDTO) {
												filterDTO = aFilterDTO;
												dispatch_semaphore_signal(semaphore);
											}fail:^(NSError *error) {
												dispatch_semaphore_signal(semaphore);
												XCTFail(@"Error: %@", error.localizedDescription);
											}];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(filterDTO, @"filterDTO is nil!");
}

- (void)testFilterByURL
{
    NSString *filter = kSearchFilerURL;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block MNSFilter *filterDTO;
    [_jiraRestClient.searchRestClient getFilterByURL:filter
                                             success:^(MNSFilter *aFilterDTO) {
                                                 filterDTO = aFilterDTO;
                                                 dispatch_semaphore_signal(semaphore);
                                             }fail:^(NSError *error) {
                                                 dispatch_semaphore_signal(semaphore);
                                                 XCTFail(@"Error: %@", error.localizedDescription);
                                             }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(filterDTO, @"filterDTO is nil!");
}

- (void)testFavouritesFilters
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSArray *favouritesFilters;
    [_jiraRestClient.searchRestClient getFavouriteFiltersWithSuccess:^(NSArray *aFavouritesFilters) {
		favouritesFilters = aFavouritesFilters;
		dispatch_semaphore_signal(semaphore);
	}fail:^(NSError *error) {
		dispatch_semaphore_signal(semaphore);
		XCTFail(@"Error: %@", error.localizedDescription);
	}];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    XCTAssertNotNil(favouritesFilters, @"favouritesFilters is nil!");
}
@end
