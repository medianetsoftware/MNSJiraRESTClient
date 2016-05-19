//
//  MNSIssueBuilder.m
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

#import "MNSIssueBuilder.h"
#import "MNSBuilderTools.h"
#import "MNSIssueBuilderFeed.h"

#import "MNSIssue.h"

#import "MNSComponent.h"
#import "MNSIssueField.h"

#import "MNSCommentBuilder.h"
#import "MNSBasicIssueBuilder.h"
#import "MNSAttachmentBuilder.h"
#import "MNSIssueTypeBuilder.h"
#import "MNSPriorityBuilder.h"
#import "MNSBasicResolutionBuilder.h"

#import "MNSUserBuilder.h"
#import "MNSComment.h"
#import "MNSIssueLink.h"
#import "MNSIssueLinkBuilder.h"
#import "MNSBasicVotes.h"
#import "MNSBasicVotesBuilder.h"
#import "MNSWorklog.h"
#import "MNSWorklogBuilder.h"
#import "MNSIssueFieldID.h"
#import "MNSBasicWatchersBuilder.h"
#import "MNSVersionBuilder.h"
#import "MNSVersion.h"
#import "MNSBasicComponentBuilder.h"
#import "MNSTimeTrackingBuilder.h"
#import "MNSSubtask.h"
#import "MNSSubtaskBuilder.h"
#import "MNSStatusBuilder.h"

@interface MNSIssueBuilder ()
@end

@implementation MNSIssueBuilder

+(id)buildWithJSONObject:(id)source error:(NSError **)error {
    
    MNSIssue *issue;

    @try {
        NSError* errorInside;
        MNSIssueBuilderFeed* issueBuilderFeed =[MNSIssueBuilderFeed createFromValidIssueSource:source error:&errorInside];
        if (!errorInside) {
            
            //BASICISSUE
            MNSBasicIssue* basicIssue = [MNSBasicIssueBuilder buildWithJSONObject:source error:error];
            issue = [MNSIssue createWithBasicIssue:basicIssue];
            
            //COMMENTS
            id commentsContainerJSON = validDictionaryForKey(issueBuilderFeed.fields, kComment);
            if (commentsContainerJSON) {
                NSArray *commentsJSON = validArrayForKey(commentsContainerJSON, @"comments");
                NSMutableArray *comments = [NSMutableArray array];
                for (id thisComment in commentsJSON) {
                    MNSComment *comment = [MNSCommentBuilder buildWithJSONObject:validDictionary(thisComment) error:error];
                    [comments addObject:comment];
                }
                issue.comments = comments;
            }
            
            //SUMMARY
            issue.summary = (NSString*)objectFromDicForkey(issueBuilderFeed.fields, kSummary);
            
            //DESCRIPTION
            issue.description = (NSString*)objectFromDicForkey(issueBuilderFeed.fields, kDescription);
            
            //ATTACHMENTS
            id attachmentsJSON = validArrayForKey(issueBuilderFeed.fields, kAttechment);
            if (attachmentsJSON) {
                for (id thisAttachment in attachmentsJSON) {
                    if(!issue.attachments) {
                        issue.attachments = [[NSArray alloc] init];
                    }
                    issue.attachments = [issue.attachments arrayByAddingObject:[MNSAttachmentBuilder buildWithJSONObject:validDictionary(thisAttachment) error:error]];
                }
            }
            
            //FIELDS
            issue.issueFields = [issueBuilderFeed issueFields];
            
            //ISSUETYPE
			if (validDictionaryForKey(issueBuilderFeed.fields,kIssuetype)) {
                issue.issueType = [MNSIssueTypeBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields,kIssuetype ) error:error];
			}
			
            //CREATIONDATE
            issue.creationDate = [MNSBuilderTools dateFromString:objectFromDicForkey(issueBuilderFeed.fields, kCreated)];
            
            //UPDATEDATE
            issue.updateDate = [MNSBuilderTools dateFromString:objectFromDicForkey(issueBuilderFeed.fields, kUpdateDate)];
            
            //DUEDATE
			NSString *dueDate = validStringForkey(issueBuilderFeed.fields, kDuedate);
			if (dueDate) {
				issue.dueDate = [MNSBuilderTools shortDateFromString:dueDate];
			}
			
            //PRIORITY
			if (validDictionaryForKey(issueBuilderFeed.fields, kPriority)) {
                issue.priority = [MNSPriorityBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kPriority) error:error];
			}
			
            //RESOLUTION
			if (validDictionaryForKey(issueBuilderFeed.fields, kResolution)) {
                issue.resolution = [MNSBasicResolutionBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kResolution) error:error];
			}
			
            //ASSIGNEE
			if (validDictionaryForKey(issueBuilderFeed.fields, kAssignee)) {
                issue.assignee = [MNSUserBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kAssignee) error:error];
			}
			
            //REPORTER
			if (validDictionaryForKey(issueBuilderFeed.fields, kReporter)) {
                issue.reporter = [MNSUserBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kReporter) error:error];
			}
			
            //ISSUELINKS
            NSArray *issueLinksContainerJSON = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:LINKS_FIELD]);
			if (issueLinksContainerJSON) {
				NSMutableArray *issueLinks = [NSMutableArray array];
				for (NSDictionary *issueLinkJSON in issueLinksContainerJSON) {
					MNSIssueLink *issueLink = [MNSIssueLinkBuilder buildWithJSONObject:validDictionary(issueLinkJSON) error:error];
					[issueLinks addObject:issueLink];
				}
				issue.issueLinks = issueLinks;
			}
			
            //VOTES
            NSDictionary *votesJSON = validDictionaryForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:VOTES_FIELD]);
			if (votesJSON) {
                issue.votes = [MNSBasicVotesBuilder buildWithJSONObject:votesJSON error:error];
			}
			
            //WORKLOGS
            id worklogContainerJSON = validDictionaryForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:WORKLOG_FIELD]);
            if (worklogContainerJSON) {
                NSArray *worklogsJSON = validArrayForKey(worklogContainerJSON, @"worklogs");
                NSMutableArray *worklogs = [NSMutableArray array];
                for (id thisWorklog in worklogsJSON) {
                    MNSWorklog *worklog = [MNSWorklogBuilder buildWithJSONObject:validDictionary(thisWorklog) error:error issuefURL:issue.selfUrl]; //TODO error
                    [worklogs addObject:worklog];
                }
                issue.worklogs = worklogs;
            }
            
            //WATCHERS
            NSDictionary *watchersJSON = validDictionaryForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:WATCHER_FIELD]);
            if (watchersJSON)
                issue.watchers = [MNSBasicWatchersBuilder buildWithJSONObject:watchersJSON error:error];
            
            //FIXVERSIONS
            NSArray *fixVersionsContainerJSON = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:FIX_VERSIONS_FIELD]);
			if (fixVersionsContainerJSON) {
				NSMutableArray *fixVersions = [NSMutableArray array];
				for (NSDictionary *fixVersionJSON in fixVersionsContainerJSON) {
					MNSVersion *version = [MNSVersionBuilder buildWithJSONObject:validDictionary(fixVersionJSON) error:error];
					[fixVersions addObject:version];
				}
				issue.fixVersions = fixVersions;
			}
			
            //AFFECTEDVERSIONS
            NSArray *affectedVersionsContainerJSON = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:AFFECTS_VERSIONS_FIELD]);
			if (affectedVersionsContainerJSON) {
				NSMutableArray *affectedVersions = [NSMutableArray array];
				for (NSDictionary *affectedVersionJSON in affectedVersionsContainerJSON) {
					MNSVersion *version = [MNSVersionBuilder buildWithJSONObject:validDictionary(affectedVersionJSON) error:error];
					[affectedVersions addObject:version];
				}
				issue.affectedVersions = affectedVersions;
			}
			
            //COMPONENTS
            NSArray *componentsContainerJSON = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:COMPONENTS_FIELD]);
			if (componentsContainerJSON) {
				NSMutableArray *components = [NSMutableArray array];
				for (NSDictionary *componentJSON in componentsContainerJSON) {
					MNSBasicComponent *component = [MNSBasicComponentBuilder buildWithJSONObject:validDictionary(componentJSON) error:error];
					[components addObject:component];
				}
				issue.components = components;
			}
			
            //TIMETRACKING
            NSDictionary *timeTrackingJSON = validDictionaryForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:TIMETRACKING_FIELD]);
			if (timeTrackingJSON.count > 0) {
                issue.timeTracking = [MNSTimeTrackingBuilder buildWithJSONObject:timeTrackingJSON error:error];
			}
			
            //SUBTASKS
            NSArray *subtasksContainerJSON = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:SUBTASKS_FIELD]);
			if (subtasksContainerJSON) {
				NSMutableArray *subtasks = [NSMutableArray array];
				for (NSDictionary *subtaskJSON in subtasksContainerJSON) {
					MNSSubtask *subtask = [MNSSubtaskBuilder buildWithJSONObject:validDictionary(subtaskJSON) error:error];
					[subtasks addObject:subtask];
				}
				issue.subtasks = subtasks;
			}
			
            //CHANGELOG
            issue.changelog = [issueBuilderFeed changelog];
            
            //LABELS
			NSArray *labels = validArrayForKey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:LABELS_FIELD]);
			issue.labels = labels;
			
			//STATUS
			if (validDictionaryForKey(issueBuilderFeed.fields, kStatus)) {
				issue.status = [MNSStatusBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kStatus) error:error];
			}
        }
		
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"IssuelBuilder error:Exception" code:0 userInfo:nil];
        return nil;
    }
    
    return issue;

    
}

@end
