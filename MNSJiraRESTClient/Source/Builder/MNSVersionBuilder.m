//
//  MNSVersionBuilder.m
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
#import "MNSVersionBuilder.h"
#import "MNSVersion.h"

#define ID @"id"
#define SELF @"self"
#define NAME @"name"
#define DESCRIPTION @"description"
#define ARCHIVED @"archived"
#define RELEASED @"released"
#define RELEASEDATE @"releaseDate"

@implementation MNSVersionBuilder


+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    
    MNSVersion *version;

    @try {
        
        if (validDictionary(source)) {
             version = [[MNSVersion alloc] initWithUrl:[source objectForKey:SELF] identifier:[[source objectForKey:ID] intValue] description:[source objectForKey:DESCRIPTION] name:[source objectForKey:NAME] isArchived:[[source objectForKey:ARCHIVED] boolValue] isReleased:[[source objectForKey:RELEASED] boolValue] releaseDate:[source objectForKey:RELEASEDATE]];
        }
        else{
            *error = [NSError errorWithDomain:@"Version error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"Version error:Exception" code:0 userInfo:nil];
    }
    
    return version;

}

@end
