//
//  MNSBasicIssueTypeBuilder.m
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
#import "MNSBasicIssueTypeBuilder.h"

#import "MNSBasicIssueType.h"


@implementation MNSBasicIssueTypeBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    MNSBasicIssueType* issueType;

    @try {
        if(validDictionary(source)){
            issueType = [[MNSBasicIssueType alloc] init];
            issueType.identifier = objectFromDicForkey(source, kID);
            issueType.name = objectFromDicForkey(source, kName);
            issueType.selfUrl = objectFromDicForkey(source, kSelfURL);
            issueType.subTask = [objectFromDicForkey(source, kSubtask) boolValue];
            
        }
        else {
            *error = [NSError errorWithDomain:@"BasicIssueTypeBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicIssueTypeBuilder error:Exception" code:0 userInfo:nil];

    }
    return issueType;

   
}

@end
