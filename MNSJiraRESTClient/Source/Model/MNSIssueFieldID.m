//
//  MNSIssueFieldID.m
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

#import "MNSIssueFieldID.h"

static NSString *kIssueFieldIDType_versions = @"versions";
static NSString *kIssueFieldIDType_assignee = @"assignee";
static NSString *kIssueFieldIDType_attachment = @"attachment";
static NSString *kIssueFieldIDType_comment = @"comment";
static NSString *kIssueFieldIDType_components = @"components";
static NSString *kIssueFieldIDType_created = @"created";
static NSString *kIssueFieldIDType_description = @"description";
static NSString *kIssueFieldIDType_duedate = @"duedate";
static NSString *kIssueFieldIDType_fixVersions = @"fixVersions";
static NSString *kIssueFieldIDType_issuetype = @"issuetype";
static NSString *kIssueFieldIDType_labels = @"labels";
static NSString *kIssueFieldIDType_issuelinks = @"issuelinks";
static NSString *kIssueFieldIDType_links = @"links";
static NSString *kIssueFieldIDType_priority = @"priority";
static NSString *kIssueFieldIDType_project = @"project";
static NSString *kIssueFieldIDType_reporter = @"reporter";
static NSString *kIssueFieldIDType_resolution = @"resolution";
static NSString *kIssueFieldIDType_status = @"status";
static NSString *kIssueFieldIDType_subtasks = @"subtasks";
static NSString *kIssueFieldIDType_summary = @"summary";
static NSString *kIssueFieldIDType_timetracking = @"timetracking";
static NSString *kIssueFieldIDType_transitions = @"transitions";
static NSString *kIssueFieldIDType_updated = @"updated";
static NSString *kIssueFieldIDType_votes = @"votes";
static NSString *kIssueFieldIDType_watches = @"watches";
static NSString *kIssueFieldIDType_watcher = @"watcher";
static NSString *kIssueFieldIDType_worklog = @"worklog";
static NSString *kIssueFieldIDType_worklogs = @"worklogs";

@implementation MNSIssueFieldID

+ (NSSet *)specialIssueFieldIDSet {
	return [NSSet setWithObjects:kIssueFieldIDType_versions, kIssueFieldIDType_assignee, kIssueFieldIDType_attachment,
	        kIssueFieldIDType_comment, kIssueFieldIDType_components, kIssueFieldIDType_created, kIssueFieldIDType_description,
	        kIssueFieldIDType_duedate, kIssueFieldIDType_fixVersions, kIssueFieldIDType_issuetype, kIssueFieldIDType_labels,
	        kIssueFieldIDType_issuelinks, kIssueFieldIDType_links, kIssueFieldIDType_priority, kIssueFieldIDType_project,
	        kIssueFieldIDType_reporter, kIssueFieldIDType_resolution, kIssueFieldIDType_status, kIssueFieldIDType_subtasks,
	        kIssueFieldIDType_summary, kIssueFieldIDType_timetracking, kIssueFieldIDType_transitions, kIssueFieldIDType_updated,
	        kIssueFieldIDType_votes, kIssueFieldIDType_watches, kIssueFieldIDType_watcher, kIssueFieldIDType_worklog, kIssueFieldIDType_worklogs,
	        nil];
}

+ (BOOL)existID:(NSString *)stringID {
	return [[self specialIssueFieldIDSet] containsObject:stringID];
}

+ (NSString *)issueFieldIDString:(enum MNSIssueFieldIDType)issueFieldIDType {
	NSString *issueFieldIDString;
	switch (issueFieldIDType) {
		case AFFECTS_VERSIONS_FIELD:
			issueFieldIDString = kIssueFieldIDType_versions;
			break;

		case ASSIGNEE_FIELD:
			issueFieldIDString = kIssueFieldIDType_assignee;
			break;

		case ATTACHMENT_FIELD:
			issueFieldIDString = kIssueFieldIDType_attachment;
			break;

		case COMMENT_FIELD:
			issueFieldIDString = kIssueFieldIDType_comment;
			break;

		case COMPONENTS_FIELD:
			issueFieldIDString = kIssueFieldIDType_components;
			break;

		case CREATED_FIELD:
			issueFieldIDString = kIssueFieldIDType_created;
			break;

		case DESCRIPTION_FIELD:
			issueFieldIDString = kIssueFieldIDType_description;
			break;

		case DUE_DATE_FIELD:
			issueFieldIDString = kIssueFieldIDType_duedate;
			break;

		case FIX_VERSIONS_FIELD:
			issueFieldIDString = kIssueFieldIDType_fixVersions;
			break;

		case ISSUE_TYPE_FIELD:
			issueFieldIDString = kIssueFieldIDType_issuetype;
			break;

		case LABELS_FIELD:
			issueFieldIDString = kIssueFieldIDType_labels;
			break;

		case LINKS_FIELD:
			issueFieldIDString = kIssueFieldIDType_issuelinks;
			break;

		case LINKS_PRE_5_0_FIELD:
			issueFieldIDString = kIssueFieldIDType_links;
			break;

		case PRIORITY_FIELD:
			issueFieldIDString = kIssueFieldIDType_priority;
			break;

		case PROJECT_FIELD:
			issueFieldIDString = kIssueFieldIDType_project;
			break;

		case REPORTER_FIELD:
			issueFieldIDString = kIssueFieldIDType_reporter;
			break;

		case RESOLUTION_FIELD:
			issueFieldIDString = kIssueFieldIDType_resolution;
			break;

		case STATUS_FIELD:
			issueFieldIDString = kIssueFieldIDType_status;
			break;

		case SUBTASKS_FIELD:
			issueFieldIDString = kIssueFieldIDType_subtasks;
			break;

		case SUMMARY_FIELD:
			issueFieldIDString = kIssueFieldIDType_summary;
			break;

		case TIMETRACKING_FIELD:
			issueFieldIDString = kIssueFieldIDType_timetracking;
			break;

		case TRANSITIONS_FIELD:
			issueFieldIDString = kIssueFieldIDType_transitions;
			break;

		case UPDATED_FIELD:
			issueFieldIDString = kIssueFieldIDType_updated;
			break;

		case VOTES_FIELD:
			issueFieldIDString = kIssueFieldIDType_votes;
			break;

		case WATCHER_FIELD:
			issueFieldIDString = kIssueFieldIDType_watches;
			break;

		case WATCHER_PRE_5_0_FIELD:
			issueFieldIDString = kIssueFieldIDType_watcher;
			break;

		case WORKLOG_FIELD:
			issueFieldIDString = kIssueFieldIDType_worklog;
			break;

		case WORKLOGS_FIELD:
			issueFieldIDString = kIssueFieldIDType_worklogs;
			break;
	}
	return issueFieldIDString;
}

@end
