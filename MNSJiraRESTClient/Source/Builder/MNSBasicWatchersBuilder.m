//
//  MNSBasicWatchersBuilder.m
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

#import "MNSBasicWatchersBuilder.h"
#import "MNSBasicWatchers.h"



@implementation MNSBasicWatchersBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError **)error {
    MNSBasicWatchers *basicWatchers;

    @try {
        if (validDictionary(source)) {
            NSString *selfURL = objectFromDicForkey(source, kSelfURL);
            NSNumber *watchCount = objectFromDicForkey(source, kWatchCount);
            NSNumber *isWatching = objectFromDicForkey(source, kIsWatching);
            basicWatchers = [[MNSBasicWatchers alloc] initWithSelfUrl:selfURL isWatching:[isWatching boolValue] numWatchers:[watchCount integerValue]];
        }
        else {
            *error = [NSError errorWithDomain:@"BasicWatchersBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicWatchersBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return basicWatchers;

    
}

@end
