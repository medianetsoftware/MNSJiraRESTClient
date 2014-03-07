//
//  MNSStatusBuilder.m
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

#import "MNSStatusBuilder.h"
#import "MNSStatus.h"

@implementation MNSStatusBuilder




+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    MNSStatus *status;
    @try {
        
        if (validDictionary(source)) {
            status = [[MNSStatus alloc] init];
            status.selfUrl = objectFromDicForkey(source, kSelfURL);
            status.iconUrl = objectFromDicForkey(source, kIconUrl);
            status.name = objectFromDicForkey(source, kName);
            status.description = objectFromDicForkey(source, description);
            
        }else {
            *error = [NSError errorWithDomain:@"StatusBuilder error" code:0 userInfo:nil];

        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"StatusBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return status;

    
}

@end
