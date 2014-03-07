//
//  MNSBasicUserBuilder.m
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

#import "MNSBasicUserBuilder.h"
#import "MNSBasicUser.h"



@implementation MNSBasicUserBuilder

+(id)buildWithJSONObject:(id)source error:(NSError **)error {
    MNSBasicUser *basicUser;

    @try {
        
        if (validDictionary(source)) {
            NSString *selfUrl = objectFromDicForkey(source, kSelfURL);
            NSString *name = objectFromDicForkey(source, kName);
            NSString *displayName = objectFromDicForkey(source, kDisplayName);
            basicUser = [[MNSBasicUser alloc] initWithUrl:selfUrl name:name displayName:displayName];
        }else {
            *error = [NSError errorWithDomain:@"BasicUserBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicUserBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return basicUser;

}

@end
