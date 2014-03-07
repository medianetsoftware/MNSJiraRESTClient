//
//  MNSProjectRoleBuilder.m
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

#import "MNSProjectRoleBuilder.h"
#import "MNSBasicProjectRoleBuilder.h"
#import "MNSRoleActorBuilder.h"
#import "MNSRoleActor.h"



@implementation MNSProjectRoleBuilder

+ (MNSProjectRole*)buildWithJSONObject:(id)source error:(NSError**)error {
    MNSProjectRole *projectRoleDTO;

    @try {
        
        if (validDictionary(source)) {
            MNSBasicProjectRole *basicProjectRole = [MNSBasicProjectRoleBuilder buildWithJSONObject:source error:error];
            
            NSString *description = objectFromDicForkey(source, kDescription);
            NSNumber *ID = objectFromDicForkey(source, kID);
            NSArray *actorsJSON = objectFromDicForkey(source, kActors);
            NSMutableArray *actors = [NSMutableArray array];
            for (id actorJSON in actorsJSON) {
                MNSRoleActor *roleActorDTO = [MNSRoleActorBuilder buildWithJSONObject:actorJSON error:error]; 
                [actors addObject:roleActorDTO];
            }
            
            projectRoleDTO = [[MNSProjectRole alloc] initWithUrl:basicProjectRole.selfUrl name:basicProjectRole.name
                                                     description:description
                                                              ID:[ID integerValue]
                                                          actors:actors];
        } else {
            *error = [NSError errorWithDomain:@"ProjectRoleBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ProjectRoleBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return projectRoleDTO;

    
}

@end
