//
//  MNSIssueLinkBuilder.m
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

#import "MNSIssueLinkBuilder.h"
#import "MNSIssueLink.h"
#import "MNSIssueLinksTypeBuilder.h"
#import "MNSIssueLinksType.h"



@implementation MNSIssueLinkBuilder

+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    
    MNSIssueLink *issueLink;

    @try {
        
        if (validDictionary(source)) {
            NSDictionary *typeDict = objectFromDicForkey(source, kType);
            NSDictionary *outwardIssue = objectFromDicForkey(source, kOutwardIssue);
            NSDictionary *inwardIssue = objectFromDicForkey(source, kInwardIssue);
            NSDictionary *link;
            
			//We build the issueLinkType using issueLinksType and our own issue link
            MNSIssueLinksType *issueLinksType = [MNSIssueLinksTypeBuilder buildWithJSONObject:typeDict error:error];
            MNSIssueLinkType *issueLinkType = [[MNSIssueLinkType alloc] init];
            if (inwardIssue) {
                issueLinkType.direction = MNSIssueLinkTypeDirectionInbound;
                link = inwardIssue;
                issueLinkType.description = issueLinksType.inward;
            }else if (outwardIssue) {
                issueLinkType.direction = MNSIssueLinkTypeDirectionOutbound;
                link = outwardIssue;
                issueLinkType.description = issueLinksType.outward;
            }
            issueLinkType.name = issueLinksType.name;
            
            NSString *targetIssueKey = objectFromDicForkey(link, kKey);
            NSString *targetIssueURL = objectFromDicForkey(link, kTargetSelf);
            
            issueLink = [[MNSIssueLink alloc] initWithTargetIssueKey:targetIssueKey targetIssueURL:targetIssueURL issueLinkType:issueLinkType];
        }else {
            *error = [NSError errorWithDomain:@"IssueLinkBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"IssueLinkBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return issueLink;

    
}

@end
