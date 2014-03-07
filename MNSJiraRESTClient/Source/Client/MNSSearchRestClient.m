//
//  MNSSearchRestClient.m
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
#import "MNSSearchRestClient.h"
#import "MNSSearchResultBuilder.h"
#import "MNSFilterBuilder.h"

static NSString *const kSearchUriPrefix = @"/search";
static NSString *const kFilterFavouritePath = @"/filter/favourite";
static NSString *const kFilterPathFormat = @"/filter/%ld";
static NSString *const kJQLAttribute = @"jql";
static NSString *const kExpandAttribute = @"expand";
static NSString *const kFieldAttribute = @"fields";
static NSString *const kMaxResultsAttribute = @"maxResults";
static NSString *const kStartAtAttribute = @"startAt";
static NSInteger const kMaxJQLLenghtForHTTPGet = 500;

@implementation MNSSearchRestClient

-(id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator*)authenticator {
    self = [super initWithBaseUri:baseUri authenticator:authenticator];
    if (self){
        _searchURLString = [baseUri stringByAppendingString:kSearchUriPrefix];
        _favouriteURLString = [baseUri stringByAppendingString:kFilterFavouritePath];
    }
    return self;
}

-(void)searchJQL:(NSString*)jql success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail {
    [self searchJQL:jql maxResults:0 startAt:0 fields:nil success:success fail:fail];
}

-(void)searchJQL:(NSString*)jql maxResults:(NSInteger)maxResults startAt:(NSInteger)startAt fields:(NSArray*)fields success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail {
    if (jql == nil) {
        jql = @"";
    }
    
    if (jql.length > kMaxJQLLenghtForHTTPGet) {
        [self postSearchJQL:jql maxResults:maxResults startAt:startAt fields:fields success:success fail:fail];
    }else {
        [self getSearchJQL:jql maxResults:maxResults startAt:startAt fields:fields success:success fail:fail];
    }
}

-(void)getFavouriteFiltersWithSuccess:(void (^)(NSArray *favouritesFilters))success fail:(MNSRestClientFailBlock)fail {
    [self getUrl:_favouriteURLString
         success:^(NSArray *response) {
             if (success) {
                 NSMutableArray *favouritesFilters = [NSMutableArray array];
                 NSError* error;
                 
                 for (NSDictionary *filterDictionary in response) {
                     
                     MNSFilter *filterDTO = [MNSFilterBuilder buildWithJSONObject:filterDictionary error:&error];
                     [favouritesFilters addObject:filterDTO];
                 }
                 
                 if (success && [error.domain length] == 0) {
                     success(favouritesFilters);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}

-(void)getFilterByID:(long)filterID success:(void (^)(MNSFilter *filterDTO))success fail:(MNSRestClientFailBlock)fail {
    NSString *url = [self.baseUri stringByAppendingFormat:kFilterPathFormat, filterID];
    [self getFilterByURL:url success:success fail:fail];
}

-(void)getFilterByURL:(NSString*)filterURL success:(void (^)(MNSFilter *filterDTO))success fail:(MNSRestClientFailBlock)fail {
    [self getUrl:filterURL
         success:^(id response) {
             if (success) {
                 NSError* error;
                 
                 MNSFilter *filterDTO = [MNSFilterBuilder buildWithJSONObject:response error:&error];
                 
                 if (success && [error.domain length] == 0) {
                     success(filterDTO);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}

#pragma mark - Private imp

-(void)getSearchJQL:(NSString*)jql maxResults:(NSInteger)maxResults startAt:(NSInteger)startAt fields:(NSArray*)fields success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail  {
    
    NSMutableDictionary *parametersInURL = [NSMutableDictionary dictionary];
    [parametersInURL setObject:jql forKey:kJQLAttribute];
    
    NSArray *expandosValues = [NSArray arrayWithObjects:@"schema", @"names", nil];
    [parametersInURL setObject:[expandosValues componentsJoinedByString:@","] forKey:kExpandAttribute];
    
    if (fields) {
        [parametersInURL setObject:[fields componentsJoinedByString:@","] forKey:kFieldAttribute];
    }
    
    if (maxResults) {
        [parametersInURL setObject:[NSNumber numberWithInteger:maxResults] forKey:kMaxResultsAttribute];
    }
    
    [parametersInURL setObject:[NSNumber numberWithInteger:startAt] forKey:kStartAtAttribute];
    
    [self getUrl:_searchURLString parametersInURL:parametersInURL
         success:^(id response) {
             if (success) {
                 NSError* error;
                 
                 MNSSearchResult *searchResultDTO = [MNSSearchResultBuilder buildWithJSONObject:response error:&error];
                 
                 if (success && [error.domain length] == 0) {
                     success(searchResultDTO);
                 }
                 else{
                     if(fail)
                         fail(error);
                 }
             }
         } fail:^(NSError *error) {
             if (fail) {
                 fail(error);
             }
         }];
}

-(void)postSearchJQL:(NSString*)jql maxResults:(NSInteger)maxResults startAt:(NSInteger)startAt fields:(NSArray*)fields success:(void (^)(MNSSearchResult *searchResultDTO))success fail:(MNSRestClientFailBlock)fail {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:jql forKey:kJQLAttribute];
    
    NSArray *expandosValues = [NSArray arrayWithObjects:@"schema", @"names", nil];
    [parameters setObject:expandosValues forKey:kExpandAttribute];
    
    if (fields) {
        [parameters setObject:fields forKey:kFieldAttribute];
    }
    
    if (maxResults) {
        [parameters setObject:[NSNumber numberWithInteger:maxResults] forKey:kMaxResultsAttribute];
    }
    
    [parameters setObject:[NSNumber numberWithInteger:startAt] forKey:kStartAtAttribute];
    
    [self postUrl:_searchURLString
   bodyJSONObject:parameters
          success:^(id response) {
              if (success) {
                  NSError* error;
                  
                  MNSSearchResult *searchResultDTO = [MNSSearchResultBuilder buildWithJSONObject:response error:&error];
                  if (success && [error.domain length] == 0) {
                      success(searchResultDTO);
                  }
                  else{
                      if(fail)
                          fail(error);
                  }
              }
          } fail:^(NSError *error) {
              if (fail) {
                  fail(error);
              }
          }];
}

@end

