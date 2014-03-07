//
//  MNSResolutionBuilder.m
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

#import "MNSResolutionBuilder.h"
#import "MNSResolution.h"

#define DESCRIPTION @"description"

@implementation MNSResolutionBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    MNSResolution *resolution;

    @try {
        if(validDictionary(source)){
            resolution = [[MNSResolution alloc] init];
            resolution.selfUrl = objectFromDicForkey(source, kSelfURL);
            resolution.identifier = objectFromDicForkey(source, kID);
            resolution.name = objectFromDicForkey(source, kName);
            resolution.description = objectFromDicForkey(source, kDescription);
        }
        else {
            *error = [NSError errorWithDomain:@"ResolutionBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ResolutionBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return resolution;

}

@end
