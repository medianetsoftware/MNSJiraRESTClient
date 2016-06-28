//
//  MNSIssueTypeBuilder.m
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

#import "MNSIssueTypeBuilder.h"
#import "MNSIssueType.h"
#import "MNSBasicIssueType.h"

@implementation MNSIssueTypeBuilder


+ (id)buildWithJSONObject:(id)source error:(NSError **)error{
    MNSIssueType *issueType;

    @try {
        
        
        if (validDictionary(source)){
            
            NSDictionary *sourceDic = validDictionary(source);
            
            issueType = [[MNSIssueType alloc] init];
            [issueType setSelfUrl:[sourceDic objectForKey:kSelfURL]];
            [issueType setIdentifier:[sourceDic objectForKey:kID]];
            [issueType setDescription:[sourceDic objectForKey:kDescription]];
            [issueType setIconUrl:[sourceDic objectForKey:kIconUrl]];
            [issueType setName:[sourceDic objectForKey:kName]];
            [issueType setSubTask:[[sourceDic objectForKey:kSubtask] boolValue]];
			[issueType setFields:[sourceDic objectForKey:kFields]];            
        }
        else {
            *error = [NSError errorWithDomain:@"IssueTypeBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"IssueTypeBuilder error:Exception" code:0 userInfo:nil];
    }
    
    return issueType;

}

@end
