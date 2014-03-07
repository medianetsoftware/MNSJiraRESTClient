//
//  MNSChangelogItemBuilder.m
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

#import "MNSChangelogItemBuilder.h"
#import "MNSChangelogItem.h"
#import "MNSField.h"



@implementation MNSChangelogItemBuilder

+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    MNSChangelogItem *changelogItem;

    @try {
        if (validDictionary(source)) {
            NSString *fieldTypeString = objectFromDicForkey(source, kFieldtype);
            Fieldtype fieldType;
            if ([fieldTypeString isEqualToString:kJiraFieldType]) {
                fieldType = JIRA;
            }else {
                fieldType = CUSTOM;
            }
            
            NSString *field = objectFromDicForkey(source, kField);
            NSString *from = objectFromDicForkey(source, kFrom);
            NSString *fromString = objectFromDicForkey(source, kFromString);
            NSString *to = objectFromDicForkey(source, kTo);
            NSString *toString = objectFromDicForkey(source, kToString);
            
            changelogItem = [[MNSChangelogItem alloc] initWithFieldType:fieldType field:field from:from fromString:fromString to:to toString:toString];
        }else {
            *error = [NSError errorWithDomain:@"ChangeLogItemBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ChangeLogItemBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return changelogItem;

    
}

@end
