//
//  IssueInput.h
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
#import "MNSFieldInput.h"

#import "MNSBasicUser.h"
#import "MNSBasicProject.h"
#import "MNSIssueType.h"
#import "MNSBasicComponent.h"
#import "MNSBasicPriority.h"


@interface MNSIssueInput : NSObject

@property (nonatomic, strong) NSMutableDictionary *fields;

+ (MNSIssueInput *)createWithProjectKey:(NSString *)projectKey issueTypeId:(NSString *)issueTypeId;

+ (MNSIssueInput *)createWithProject:(MNSBasicProject *)project issueType:(MNSIssueType *)issueType;

+ (MNSIssueInput *)createWithProjectKey:(NSString *)projectKey issueTypeId:(NSString *)issueTypeId summary:(NSString *)summary;

+ (MNSIssueInput *)createWithProject:(MNSBasicProject *)project issueType:(MNSIssueType *)issueType summary:(NSString *)summary;



- (void)setFieldInput:(MNSFieldInput *)fieldInput;

- (void)setProjectKey:(NSString *)key;
- (void)setProject:(MNSBasicProject *)project;

- (void)setIssueTypeId:(NSString *)issueTypeId;
- (void)setIssueType:(MNSIssueType *)issueType;

- (void)setSummary:(NSString *)summary;

- (void)setAssignee:(MNSBasicUser *)asignee;
- (void)setAssigneeName:(NSString *)name;

- (void)setDescription:(NSString *)description;

- (void)setAffectedVersions:(NSArray *)versionsArray;
- (void)setAffectedVersionsNames:(NSArray *)namesArray;

- (void)setComponentName:(NSString *)componentName;
- (void)setComponentNames:(NSArray *)componentsNames;
- (void)setComponent:(MNSBasicComponent *)basicComponent;
- (void)setComponents:(NSArray *)basicComponents;

- (void)setFixVersionsNames:(NSArray *)namesArray;
- (void)setFixVersions:(NSArray *)versionArray;

- (void)setDueDate:(NSDate *)dueDate;

- (void)setPriority:(MNSBasicPriority *)priority;
- (void)setPriorityId:(NSString *)identifier;

- (void)setReporter:(MNSBasicUser *)basicUser;
- (void)setReporterName:(NSString *)name;

- (void)setOriginalEstimate:(NSString *)originalEstimate;



- (MNSFieldInput *)fieldForId:(NSString *)key;

- (NSDictionary *)dictionaryVersion;
@end
