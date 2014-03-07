//
//  MNSChangelogGroupBuilder.m
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

#import "MNSChangelogGroupBuilder.h"
#import "MNSChangelogGroup.h"
#import "MNSBasicUser.h"
#import "MNSBasicUserBuilder.h"
#import "MNSBuilderTools.h"
#import "MNSChangelogItem.h"
#import "MNSChangelogItemBuilder.h"


@implementation MNSChangelogGroupBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError **)error {
    MNSChangelogGroup *changelogGroup;

    @try {
        
        if (validDictionary(source)) {
            NSDictionary *authorJSON = objectFromDicForkey(source, kAuthor);
            MNSBasicUser *author = [MNSBasicUserBuilder buildWithJSONObject:authorJSON error:error];
            
            NSString *createdString = objectFromDicForkey(source, kCreated);
            NSDate *created = [MNSBuilderTools dateFromString:createdString];
            
            NSArray *itemsJSON = objectFromDicForkey(source, kItems);
            NSMutableArray *items = [NSMutableArray array];
            for (NSDictionary *changelogItemJSON in itemsJSON) {
                MNSChangelogItem *changelogItem = [MNSChangelogItemBuilder buildWithJSONObject:changelogItemJSON error:error];
                [items addObject:changelogItem];
            }
            
            changelogGroup = [[MNSChangelogGroup alloc] initWithAuthor:author created:created items:items];
        }
        else {
            *error = [NSError errorWithDomain:@"ChangeLogGroupBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ChangeLogGroupBuilder error:exception" code:0 userInfo:nil];
    }
    
    return changelogGroup;

    
}

@end
