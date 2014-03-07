//
//  MNSBasicProjectRoleBuilder.m
//  MNSJiraRESTClient
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

#import "MNSBasicProjectRoleBuilder.h"


@implementation MNSBasicProjectRoleBuilder

+ (MNSBasicProjectRole*)buildWithJSONObject:(id)source error:(NSError**)error {
    MNSBasicProjectRole *basicProjectRole;

    @try {
        
        if (validDictionary(source)) {
            NSString *selfUrl = objectFromDicForkey(source, kSelfURL);
            NSString *name = objectFromDicForkey(source, kName);
            basicProjectRole = [[MNSBasicProjectRole alloc] initWithUrl:selfUrl name:name];
        }else {
            *error = [NSError errorWithDomain:@"BasicProjectRoleBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicProjectRoleBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return basicProjectRole;


   
}

+ (MNSBasicProjectRole*)buildWithJSONObject:(id)source error:(NSError**)error keyString:(NSString*)keyString {
    MNSBasicProjectRole *basicProjectRole;

    @try {
        if (validDictionary(source)) {
            NSString *URLString = objectFromDicForkey(source, keyString);
            basicProjectRole = [[MNSBasicProjectRole alloc] initWithUrl:URLString name:keyString];
        }else {
            *error = [NSError errorWithDomain:@"BasicProjectRoleBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicProjectRoleBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return basicProjectRole;

    
}

@end
