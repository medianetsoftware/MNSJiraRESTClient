//
//  MNSSubtaskBuilder.m
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

#import "MNSSubtaskBuilder.h"
#import "MNSSubtask.h"
#import "MNSIssueType.h"
#import "MNSStatus.h"
#import "MNSStatusBuilder.h"
#import "MNSIssueTypeBuilder.h"



@implementation MNSSubtaskBuilder

+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    MNSSubtask *subtask;

    @try {
        
        if (validDictionary(source)) {
            NSString *issueURL = objectFromDicForkey(source, kSelfURL);
            NSString *key = objectFromDicForkey(source, kKey);
            
            NSDictionary *fieldsJSON = objectFromDicForkey(source, kFields);
            
            NSString *summary = objectFromDicForkey(fieldsJSON, kSummary);
            
            NSDictionary *statusJSON = validDictionaryForKey(fieldsJSON, kStatus);
            MNSStatus *status = [MNSStatusBuilder buildWithJSONObject:statusJSON error:error];
            
            NSDictionary *issuetypeJSON = validDictionaryForKey(fieldsJSON, kIssuetype);
            MNSIssueType *issueType = [MNSIssueTypeBuilder buildWithJSONObject:issuetypeJSON error:error];
            
            subtask = [[MNSSubtask alloc] initWithIssueKey:key issueURL:issueURL summary:summary issueType:issueType status:status];
        }else {
            *error = [NSError errorWithDomain:@"SubtaskBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"SubtaskBuilder error:Exception" code:0 userInfo:nil];
    }
    return subtask;

}

@end
