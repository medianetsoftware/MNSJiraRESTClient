//
//  MNSIssue.h
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

#import "MNSBasicIssue.h"

#import "MNSBasicStatus.h"
#import "MNSBasicIssueType.h"
#import "MNSUser.h"
#import "MNSBasicVotes.h"
#import "MNSBasicWatchers.h"
#import "MNSBasicPriority.h"
#import "MNSTimeTracking.h"
#import "MNSBasicResolution.h"

@interface MNSIssue : MNSBasicIssue


@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) id project;
@property (nonatomic, strong) MNSBasicStatus *status;

@property (nonatomic, copy) NSString *description;

@property (nonatomic,  strong) MNSBasicResolution *resolution;

@property (nonatomic, strong) NSArray *expandos;

@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, strong) NSArray *attachments;

@property (nonatomic, strong) NSArray *issueFields;

@property (nonatomic, strong) MNSBasicIssueType *issueType;

@property (nonatomic, strong) MNSBasicUser *reporter;

@property (nonatomic, strong) MNSBasicUser *assignee;

@property (nonatomic, strong) NSDate *creationDate;

@property (nonatomic, strong) NSDate *updateDate;

@property (nonatomic, strong) NSDate *dueDate;

 @property (nonatomic, strong) NSArray* issueLinks;
 @property (nonatomic, strong) MNSBasicVotes* votes;
 @property (nonatomic, strong) NSArray* worklogs;
 @property (nonatomic, strong) MNSBasicWatchers* watchers;
 @property (nonatomic, strong) NSArray* fixVersions;
 @property (nonatomic, strong) NSArray* affectedVersions;
 @property (nonatomic, strong) NSArray* components;

@property (nonatomic, strong) MNSBasicPriority *priority;

@property (nonatomic, strong) MNSTimeTracking *timeTracking;
@property (nonatomic, strong) NSArray *subtasks;
@property (nonatomic, strong) NSArray *changelog;
@property (nonatomic, strong) NSArray *labels;

+ (MNSIssue *)createWithBasicIssue:(MNSBasicIssue *)basicIssue;
- (id)initWithBasicIssue:(MNSBasicIssue *)basicIssue;

@end
