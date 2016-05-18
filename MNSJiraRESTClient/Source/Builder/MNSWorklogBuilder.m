//
//  MNSWorklogBuilder.m
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

#import "MNSWorklogBuilder.h"
#import "MNSBasicUserBuilder.h"
#import "MNSBuilderTools.h"



@implementation MNSWorklogBuilder


+ (MNSWorklog *)buildWithJSONObject:(id)source error:(NSError **)error {
	return [self buildWithJSONObject:source error:error issuefURL:nil];
}

+ (MNSWorklog*)buildWithJSONObject:(id)source error:(NSError **)error issuefURL:(NSString*)issueURL {
    MNSWorklog *worklog = nil;

    @try {
        if (validDictionary(source)) {
            worklog = [[MNSWorklog alloc] init];
            worklog.selfUrl = objectFromDicForkey(source, kSelfURL);
            worklog.issueUri = issueURL;
            
            NSDictionary *authorJSON = validDictionaryForKey(source, kAuthor);
			if (authorJSON) {
				worklog.author = [MNSBasicUserBuilder buildWithJSONObject:authorJSON error:error];
			}
			
            NSDictionary *updateAuthorJSON = validDictionaryForKey(source, kUpdateAuthor);
			if (updateAuthorJSON) {
				worklog.updateAuthor = [MNSBasicUserBuilder buildWithJSONObject:updateAuthorJSON error:error];

			}
            worklog.comment = objectFromDicForkey(source, kComment);
            
            NSString *creationDateString = objectFromDicForkey(source, kCreated);
            worklog.creationDate = [MNSBuilderTools dateFromString:creationDateString];
            
            NSString *updateDateString = objectFromDicForkey(source, kUpdateDate);
            worklog.updateDate = [MNSBuilderTools dateFromString:updateDateString];
            
            NSString *startDateString = objectFromDicForkey(source, kStartDate);
            worklog.startDate = [MNSBuilderTools dateFromString:startDateString];
            
            NSNumber *timeSpentSeconds = objectFromDicForkey(source, kTimeSpentSeconds);
            worklog.minutesSpent = [timeSpentSeconds integerValue];
            
            NSDictionary* visibilityDic = objectFromDicForkey(source, kVisibility);
            NSString *typeVisibility = objectFromDicForkey(visibilityDic, kType);
            NSString *valueVisibility = objectFromDicForkey(visibilityDic, kValue);
            worklog.visibility = [MNSVisibility createWithVisibility:typeVisibility value:valueVisibility];
        }
        else {
            *error = [NSError errorWithDomain:@"WorkLogBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"WorkLogBuilder error:Exception" code:0 userInfo:nil];

    }
    return worklog;

}

@end
