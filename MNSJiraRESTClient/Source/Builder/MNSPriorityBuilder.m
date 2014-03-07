//
//  MNSPriorityBuilder.m
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

#import "MNSPriorityBuilder.h"
#import "MNSPriority.h"




@implementation MNSPriorityBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    MNSPriority* priority;
    @try {
        
        if(validDictionary(source)){
            priority = [[MNSPriority alloc] init];
            priority.name = objectFromDicForkey(source, kName);
            priority.selfUrl = objectFromDicForkey(source, kSelfURL);
            priority.identifier = objectFromDicForkey(source, kID);
            priority.statusColor = objectFromDicForkey(source, kStatusColor);
            priority.description = objectFromDicForkey(source, kDescription);
            priority.iconUrl = objectFromDicForkey(source, kIconUrl);

        }
        else {
            *error = [NSError errorWithDomain:@"PriorityBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"PriorityBuilder error:Exception" code:0 userInfo:nil];
    }
    return priority;

}

@end
