//
//  MNSComponentBuilder.m
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

#import "MNSComponentBuilder.h"
#import "MNSComponent.h"
#import "MNSBasicUser.h"
#import "MNSBasicUserBuilder.h"




@implementation MNSComponentBuilder


+ (id)buildWithJSONObject:(id)source error:(NSError **)error{
    MNSComponent *component;

    @try {
        if (validDictionary(source)){
            NSDictionary *sourceDic = validDictionary(source);
            
            component = [[MNSComponent alloc] init];
            
            if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kProjectDefault])
                [component setAssigneeType:PROJECT_DEFAULT];
            else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kComponentLead])
                [component setAssigneeType:COMPONENT_LEAD];
            else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kProjectLead])
                [component setAssigneeType:PROJECT_LEAD];
            else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kUnassigned])
                [component setAssigneeType:UNASSIGNED];
            
            [component setDescription:[sourceDic objectForKey:kDescription]];
            
            [component setIdentifier:[[sourceDic objectForKey:kID] intValue]];
            
            [component setLead:[MNSBasicUserBuilder buildWithJSONObject:[sourceDic objectForKey:kLead] error:error]];
            
            [component setName:[sourceDic objectForKey:kName]];
            
            if ([[sourceDic objectForKey:kSetRealAssigneeType] isEqualToString:kProjectDefault])
                [component setRealAssigneeType:PROJECT_DEFAULT];
            else if ([[sourceDic objectForKey:kSetRealAssigneeType] isEqualToString:kComponentLead])
                [component setRealAssigneeType:COMPONENT_LEAD];
            else if ([[sourceDic objectForKey:kSetRealAssigneeType] isEqualToString:kProjectLead])
                [component setRealAssigneeType:PROJECT_LEAD];
            else if ([[sourceDic objectForKey:kSetRealAssigneeType] isEqualToString:kUnassigned])
                [component setRealAssigneeType:UNASSIGNED];
            
            [component setSelfUrl:[sourceDic objectForKey:kSelfURL]];
            
            [component setIsAssigneeTypeValid:[[sourceDic objectForKey:kIsAssigneeTypeValid] boolValue]];
            
            
        }
        else {
            *error = [NSError errorWithDomain:@"ComponentBuilder error" code:0 userInfo:nil];
        }        
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ComponentBuilder error:Exception" code:0 userInfo:nil];
    }
    
    return component;

}

@end
