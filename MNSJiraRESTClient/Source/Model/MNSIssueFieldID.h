//
//  MNSIssueFieldID.h
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

NS_ENUM(NSInteger, MNSIssueFieldIDType)
{
	AFFECTS_VERSIONS_FIELD,
	ASSIGNEE_FIELD,
	ATTACHMENT_FIELD,
	COMMENT_FIELD,
	COMPONENTS_FIELD,
	CREATED_FIELD,
	DESCRIPTION_FIELD,
	DUE_DATE_FIELD,
	FIX_VERSIONS_FIELD,
	ISSUE_TYPE_FIELD,
	LABELS_FIELD,
	LINKS_FIELD,
	LINKS_PRE_5_0_FIELD,
	PRIORITY_FIELD,
	PROJECT_FIELD,
	REPORTER_FIELD,
	RESOLUTION_FIELD,
	STATUS_FIELD,
	SUBTASKS_FIELD,
	SUMMARY_FIELD,
	TIMETRACKING_FIELD,
	TRANSITIONS_FIELD,
	UPDATED_FIELD,
	VOTES_FIELD,
	WATCHER_FIELD,
	WATCHER_PRE_5_0_FIELD,
	WORKLOG_FIELD,
	WORKLOGS_FIELD
};

@interface MNSIssueFieldID : NSObject

+ (NSSet *)specialIssueFieldIDSet;

+ (BOOL)existID:(NSString *)stringID;

+ (NSString *)issueFieldIDString:(enum MNSIssueFieldIDType)issueFieldIDType;

@end
