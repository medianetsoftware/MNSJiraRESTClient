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
#import "MNSBasicIssueTypeBuilder.h"
#import "MNSBasicPriorityBuilder.h"
#import "MNSBasicResolutionBuilder.h"

#import "MNSBasicUserBuilder.h"
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
            id commentsContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, kComment);
            if (validDictionary(commentsContainerJSON)) {
                NSArray* commentsJSON = validArray(objectFromDicForkey(commentsContainerJSON, @"comments"));
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
            id attachmentsJSON = objectFromDicForkey(issueBuilderFeed.fields, kAttechment);
            if (validArray(attachmentsJSON)) {
                for (id thisAttachment in attachmentsJSON) {
                    if(!issue.attachments) {
                        issue.attachments = [[NSArray alloc] init];
                    }
                    issue.attachments = [issue.attachments arrayByAddingObject:[MNSAttachmentBuilder buildWithJSONObject:validArray(attachmentsJSON) error:error]];
                }
            }
            
            //FIELDS
            issue.issueFields = [issueBuilderFeed issueFields];
            
            //ISSUETYPE
            if (objectFromDicForkey(issueBuilderFeed.fields,kIssuetype ))
                issue.issueType = [MNSBasicIssueTypeBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields,kIssuetype ) error:error];
            
            //CREATIONDATE
            issue.creationDate = [MNSBuilderTools dateFromString:objectFromDicForkey(issueBuilderFeed.fields, kCreated)];
            
            //UPDATEDATE
            issue.updateDate = [MNSBuilderTools dateFromString:objectFromDicForkey(issueBuilderFeed.fields, kUpdateDate)];
            
            //DUEDATE
            issue.dueDate = [MNSBuilderTools dateFromString:objectFromDicForkey(issueBuilderFeed.fields, kDueDate)];
            
            //PRIORITY
            if (objectFromDicForkey(issueBuilderFeed.fields, kPriority))
                issue.priority = [MNSBasicPriorityBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kPriority) error:error];
            
            //RESOLUTION
            if (objectFromDicForkey(issueBuilderFeed.fields, kResolution) && ![objectFromDicForkey(issueBuilderFeed.fields, kResolution) isKindOfClass:[NSNull class]])
                issue.resolution = [MNSBasicResolutionBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kResolution) error:error];
            
            //ASSIGNEE
            if (objectFromDicForkey(issueBuilderFeed.fields, kAssignee))
                issue.assignee = [MNSBasicUserBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kAssignee) error:error];
            
            //REPORTER
            if (objectFromDicForkey(issueBuilderFeed.fields, kReporter))
                issue.reporter = [MNSBasicUserBuilder buildWithJSONObject:objectFromDicForkey(issueBuilderFeed.fields, kReporter) error:error];
            
            //ISSUELINKS
            NSArray *issueLinksContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:LINKS_FIELD]);
            NSMutableArray *issueLinks = [NSMutableArray array];
            for (NSDictionary *issueLinkJSON in issueLinksContainerJSON) {
                MNSIssueLink *issueLink = [MNSIssueLinkBuilder buildWithJSONObject:validDictionary(issueLinkJSON) error:error]; 
                [issueLinks addObject:issueLink];
            }
            issue.issueLinks = issueLinks;
            
            //VOTES
            NSDictionary *votesJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:VOTES_FIELD]);
            if (votesJSON)
                issue.votes = [MNSBasicVotesBuilder buildWithJSONObject:votesJSON error:error];
            
            //WORKLOGS
            id worklogContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:WORKLOG_FIELD]);
            if (validDictionary(worklogContainerJSON)) {
                NSArray *worklogsJSON = validArray(objectFromDicForkey(worklogContainerJSON, @"worklogs"));
                NSMutableArray *worklogs = [NSMutableArray array];
                for (id thisWorklog in worklogsJSON) {
                    MNSWorklog *worklog = [MNSWorklogBuilder buildWithJSONObject:validDictionary(thisWorklog) error:error issuefURL:issue.selfUrl]; //TODO error
                    [worklogs addObject:worklog];
                }
                issue.worklogs = worklogs;
            }
            
            //WATCHERS
            NSDictionary *watchersJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:WATCHER_FIELD]);
            if (watchersJSON)
                issue.watchers = [MNSBasicWatchersBuilder buildWithJSONObject:watchersJSON error:error];
            
            //FIXVERSIONS
            NSArray *fixVersionsContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:FIX_VERSIONS_FIELD]);
            NSMutableArray *fixVersions = [NSMutableArray array];
            for (NSDictionary *fixVersionJSON in fixVersionsContainerJSON) {
                MNSVersion *version = [MNSVersionBuilder buildWithJSONObject:validDictionary(fixVersionJSON) error:error];
                [fixVersions addObject:version];
            }
            issue.fixVersions = fixVersions;
            
            //AFFECTEDVERSIONS
            NSArray *affectedVersionsContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:AFFECTS_VERSIONS_FIELD]);
            NSMutableArray *affectedVersions = [NSMutableArray array];
            for (NSDictionary *affectedVersionJSON in affectedVersionsContainerJSON) {
                MNSVersion *version = [MNSVersionBuilder buildWithJSONObject:validDictionary(affectedVersionJSON) error:error];
                [affectedVersions addObject:version];
            }
            issue.affectedVersions = affectedVersions;
            
            //COMPONENTS
            NSArray *componentsContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:COMPONENTS_FIELD]);
            NSMutableArray *components = [NSMutableArray array];
            for (NSDictionary *componentJSON in componentsContainerJSON) {
                MNSBasicComponent *component = [MNSBasicComponentBuilder buildWithJSONObject:validDictionary(componentJSON) error:error];
                [components addObject:component];
            }
            issue.components = components;
            
            //TIMETRACKING
            NSDictionary *timeTrackingJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:TIMETRACKING_FIELD]);
            if (timeTrackingJSON.count > 0)
                issue.timeTracking = [MNSTimeTrackingBuilder buildWithJSONObject:timeTrackingJSON error:error];
            
            //SUBTASKS
            NSArray *subtasksContainerJSON = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:SUBTASKS_FIELD]);
            NSMutableArray *subtasks = [NSMutableArray array];
            for (NSDictionary *subtaskJSON in subtasksContainerJSON) {
                MNSSubtask *subtask = [MNSSubtaskBuilder buildWithJSONObject:validDictionary(subtaskJSON) error:error]; 
                [subtasks addObject:subtask];
            }
            issue.subtasks = subtasks;
            
            //CHANGELOG
            issue.changelog = [issueBuilderFeed changelog];
            
            //LABELS
			NSArray *labels = objectFromDicForkey(issueBuilderFeed.fields, [MNSIssueFieldID issueFieldIDString:LABELS_FIELD]);
			issue.labels = labels;
        }
        
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"IssuelBuilder error:Exception" code:0 userInfo:nil];
        return nil;
    }
    
    return issue;

    
}

@end
