//
//  MNSIssueLinkTypeBuilder.m
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

#import "MNSIssueLinksTypeBuilder.h"
#import "MNSIssueLinksType.h"



@implementation MNSIssueLinksTypeBuilder

+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    MNSIssueLinksType *issueLinksType;

    @try {
        
        if (validDictionary(source)) {
            NSString *selfURL = objectFromDicForkey(source, kSelfURL);
            NSString *ID = objectFromDicForkey(source, kID);
            NSString *name = objectFromDicForkey(source, kName);
            NSString *inward = objectFromDicForkey(source, kInward);
            NSString *outward = objectFromDicForkey(source, kOutward);
            
            issueLinksType = [[MNSIssueLinksType alloc] initWithUrl:selfURL name:name ID:ID inward:inward outward:outward];
        }else {
            *error = [NSError errorWithDomain:@"IssueLinksTypeBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"IssueLinksTypeBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return issueLinksType;

    
}

@end
