//
//  MNSBasicIssueBuilder.m
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

#import "MNSBasicIssueBuilder.h"
#import "MNSBasicIssue.h"
@implementation MNSBasicIssueBuilder

+(id)buildWithJSONObject:(id)source error:(NSError **)error{
    MNSBasicIssue* basicIssue;

    @try {
        if(source && [source isKindOfClass:[NSDictionary class]]){
            
            basicIssue = [[MNSBasicIssue alloc] init];
            basicIssue.selfUrl = objectFromDicForkey(source, kSelfURL);
            basicIssue.key = objectFromDicForkey(source, kKey);
            basicIssue.identifier = objectFromDicForkey(source, kID);
        }
        else {
            *error = [NSError errorWithDomain:@"BasicIssueBuilder error" code:0 userInfo:nil];

        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"BasicIssueBuilder error:Exception" code:0 userInfo:nil];

    }
    return basicIssue;

}

@end
