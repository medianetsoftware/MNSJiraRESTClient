//
//  MNSProjectBuilder.m
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

#import "MNSProjectBuilder.h"
#import "MNSProject.h"
#import "MNSComponent.h"
#import "MNSIssueType.h"
#import "MNSBasicUser.h"
#import "MNSBasicProjectRoleBuilder.h"
#import "MNSVersion.h"
#import "MNSBasicUserBuilder.h"
#import "MNSVersionBuilder.h"


#define a16x16 @"16x16"
#define a24x24 @"24x24"
#define a32x32 @"32x32"
#define a48x48 @"48x48"


@implementation MNSProjectBuilder


+ (id)buildWithJSONObject:(id)source error:(NSError **)error{
    
    NSDictionary *sourceDic = validDictionary(source);
    NSArray *sourceArr = validArray(source);
    
    id returnValue;

    if (sourceDic){
         returnValue = [self getProjectDTO:sourceDic error:error];
    }
    else if (sourceArr){
         returnValue = [self getArrayWithProjects:sourceArr error:error];
    }
    
    return returnValue;
}

+ (NSMutableArray*)getArrayWithProjects:(NSArray*)projectsSource error:(NSError **)error{
    NSMutableArray *projectArray = [[NSMutableArray alloc] init];

    @try {
        for (int i = 0;i<[projectsSource count];i++){
            [projectArray addObject:[self getProjectDTO:[projectsSource objectAtIndex:i] error:error]];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ProjectBuilder error:Exception" code:0 userInfo:nil];
    }
    
    return projectArray;

}

+ (MNSProject *)getProjectDTO:(NSDictionary*)sourceDic error:(NSError **)error{
    MNSProject *projectDto = [[MNSProject alloc] init];

    @try {
        
        if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kProjectDefault])
            [projectDto setAssigneeType:PROJECT_DEFAULT];
        else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kComponentLead])
            [projectDto setAssigneeType:COMPONENT_LEAD];
        else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kProjectLead])
            [projectDto setAssigneeType:PROJECT_LEAD];
        else if ([[sourceDic objectForKey:kAssigneeType] isEqualToString:kUnassigned])
            [projectDto setAssigneeType:UNASSIGNED];
        
        NSDictionary *avatarUrlsDic = @{a16x16: [[sourceDic objectForKey:kAvatarURLs] objectForKey:a16x16],a24x24: [[sourceDic objectForKey:kAvatarURLs] objectForKey:a24x24], a32x32: [[sourceDic objectForKey:kAvatarURLs] objectForKey:a32x32], a48x48: [[sourceDic objectForKey:kAvatarURLs] objectForKey:a48x48]  };
        
        [projectDto setAvatarUrls:avatarUrlsDic];
        
        NSArray *componentsInDic = [sourceDic objectForKey:kComponents];
        NSMutableArray *componentsForDto= [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in componentsInDic){
            MNSComponent *component = [[MNSComponent alloc] initWithIdentifier:[[dic objectForKey:kID] intValue] url:[dic objectForKey:kSelfURL] name:[dic objectForKey:kName] description:[dic objectForKey:kDescription]];
            [componentsForDto addObject:component];
        }
        
        [projectDto setComponents:componentsForDto];
        
        [projectDto setDescription:[sourceDic objectForKey:kDescription]];
        [projectDto setExpand:[sourceDic objectForKey:kExpand]];
        [projectDto setIdentifier:[[sourceDic objectForKey:kID] intValue]];
        
        NSArray *issueTypesInDic = [sourceDic objectForKey:kIssuetype];
        NSMutableArray *issueTypesForDto= [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in issueTypesInDic){
            MNSIssueType *issueType = [[MNSIssueType alloc] init];
            [issueType setDescription:[dic objectForKey:kDescription]];
            [issueType setIconUrl:[dic objectForKey:kIconUrl]];
            [issueType setIdentifier:[dic objectForKey:kID]];
            [issueType setName:[dic objectForKey:kName]];
            [issueType setSelfUrl:[dic objectForKey:kSelfURL]];
            [issueType setSubTask:[[dic objectForKey:kSubtask] boolValue]];
            [issueTypesForDto addObject:issueType];
        }
        
        [projectDto setIssueTypes:issueTypesForDto];
        
        [projectDto setKey:[sourceDic objectForKey:kKey]];
        
        if ([sourceDic objectForKey:kLead]){
            [projectDto setLead:[MNSBasicUserBuilder buildWithJSONObject:[sourceDic objectForKey:kLead] error:error]];

        }
        
        [projectDto setName:[sourceDic objectForKey:kName]];
        
        NSDictionary *rolesDic = [sourceDic objectForKey:kRoles];
        NSMutableArray *rolesProjectForDto= [[NSMutableArray alloc] init];
        
        for (NSString *key in [rolesDic allKeys]){
            MNSBasicProjectRole *basicProjecRole = [MNSBasicProjectRoleBuilder buildWithJSONObject:rolesDic error:error keyString:key];//TODO error
            [rolesProjectForDto addObject:basicProjecRole];
        }
        
        [projectDto setRoles:rolesProjectForDto];
        
        [projectDto setSelfUrl:[sourceDic objectForKey:kSelfURL]];
        
        NSArray *versionsInDic = [sourceDic objectForKey:kVersions];
        NSMutableArray *versinsForDto= [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in versionsInDic){
            [versinsForDto addObject:[MNSVersionBuilder buildWithJSONObject:dic error:error]];
        }
        
        [projectDto setVersions:versinsForDto];
        

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ProjectBuilder error:Exception" code:0 userInfo:nil];
    }
    
    return projectDto;

    
}

@end
