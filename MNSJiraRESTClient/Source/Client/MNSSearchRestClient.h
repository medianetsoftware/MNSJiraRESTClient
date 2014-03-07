//
//  MNSSearchRestClient.h
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
#import "MNSSearchResult.h"
#import "MNSFilter.h"

@interface MNSSearchRestClient : MNSGenericRestClient {
	NSString *_searchURLString;
	NSString *_favouriteURLString;
}

- (void)searchJQL:(NSString *)jql success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail;

- (void)searchJQL:(NSString *)jql maxResults:(NSInteger)maxResults startAt:(NSInteger)startAt fields:(NSArray *)fields success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail;

- (void)getFavouriteFiltersWithSuccess:(void (^)(NSArray *favouritesFilters))success fail:(MNSRestClientFailBlock)fail;

- (void)getFilterByID:(long)filterID success:(void (^)(MNSFilter *filterDTO))success fail:(MNSRestClientFailBlock)fail;

- (void)getFilterByURL:(NSString *)filterURL success:(void (^)(MNSFilter *filterDTO))success fail:(MNSRestClientFailBlock)fail;

@end
