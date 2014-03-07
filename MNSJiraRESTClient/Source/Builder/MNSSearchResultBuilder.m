//
//  MNSSearchResultBuilder.m
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
#import "MNSSearchResultBuilder.h"
#import "MNSSearchResult.h"
#import "MNSIssueBuilder.h"
#import "MNSIssue.h"



@implementation MNSSearchResultBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError**)error {
    
    MNSSearchResult *searchResultDTO;

    
    @try {
        
        if (validDictionary(source)) {
            
            NSNumber *startAt = objectFromDicForkey(source, kStartAt);
            NSNumber *maxResults = objectFromDicForkey(source, kMaxResults);
            NSNumber *total = objectFromDicForkey(source, kTotal);
            NSArray *issuesJSONArray = objectFromDicForkey(source, kIssues);
            NSMutableArray *issues = [NSMutableArray array];
            
            for (id issueJSON in issuesJSONArray) {
                MNSIssue *issue = [MNSIssueBuilder buildWithJSONObject:issueJSON error:error];
                [issues addObject:issue];
            }
            
            searchResultDTO = [[MNSSearchResult alloc] initWithStartIndex:[startAt integerValue]
                                                                                maxResults:[maxResults integerValue]
                                                                                     total:[total integerValue]
                                                                                    issues:issues];
            
        } else {
            *error = [NSError errorWithDomain:@"SearchResultbuilder error" code:0 userInfo:nil];
        }
        

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"SearchResultbuilder error:Exception" code:0 userInfo:nil];

    }
    
    return searchResultDTO;

   
    
}

@end
