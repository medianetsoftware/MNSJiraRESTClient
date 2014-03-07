//
//  MNSBasicResolutionBuilder.m
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

#import "MNSBasicResolutionBuilder.h"
#import "MNSBasicResolution.h"

@implementation MNSBasicResolutionBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    MNSBasicResolution *basicResolution;

    @try {
        if(validDictionary(source)){
            basicResolution = [[MNSBasicResolution alloc] init];
            basicResolution.selfUrl = objectFromDicForkey(source, kSelfURL);
            basicResolution.identifier = objectFromDicForkey(source, kID);
            basicResolution.name = objectFromDicForkey(source, kName);
        }
        else {
            *error = [NSError errorWithDomain:@"BasicResolution error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicResolution error:Exception" code:0 userInfo:nil];

    }
    return basicResolution;

}

@end
