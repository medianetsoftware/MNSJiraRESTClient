//
//  MNSRoleActorBuilder.m
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

#import "MNSRoleActorBuilder.h"
#import "MNSRoleActor.h"



@implementation MNSRoleActorBuilder

+(id)buildWithJSONObject:(id)source error:(NSError **)error {
    MNSRoleActor *roleActor;

    @try {
        
        if (validDictionary(source)) {
            NSString *name = objectFromDicForkey(source, kName);
            NSNumber *idNumber = objectFromDicForkey(source, kID);
            NSString *displayName = objectFromDicForkey(source, kDisplayName);
            NSString *type = objectFromDicForkey(source, kType);
            NSString *avatarUrl = objectFromDicForkey(source, kAvatarUrl);
            roleActor = [[MNSRoleActor alloc] initWithName:name ID:[idNumber integerValue] displayName:displayName type:type avatarUrl:avatarUrl];
        }else {
            *error = [NSError errorWithDomain:@"RoleActorBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"RoleActorBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return roleActor;

   
}

@end
