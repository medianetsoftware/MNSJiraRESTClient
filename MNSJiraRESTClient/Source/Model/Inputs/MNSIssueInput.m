//
//  IssueInput.m
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

#import "MNSIssueInput.h"

#import "MNSComplexIssueInputFieldValue.h"

#import "MNSVersion.h"

@interface MNSIssueInput ()


@end

@implementation MNSIssueInput

#pragma mark class



- (id)init {
	self = [super init];
	if (self) {
		_fields = [[NSMutableDictionary alloc] init];
	}
	return self;
}

+ (MNSIssueInput *)createWithProject:(MNSBasicProject *)project issueType:(MNSIssueType *)issueType {
	MNSIssueInput *input = [[MNSIssueInput alloc] init];
	[input setProject:project];
	[input setIssueType:issueType];
	return input;
}

+ (MNSIssueInput *)createWithProject:(MNSBasicProject *)project issueType:(MNSIssueType *)issueType summary:(NSString *)summary {
	MNSIssueInput *input = [MNSIssueInput createWithProject:project issueType:issueType];
	[input setSummary:summary];
	return input;
}

+ (MNSIssueInput *)createWithProjectKey:(NSString *)projectKey issueTypeId:(NSString *)issueTypeId {
	MNSIssueInput *input = [[MNSIssueInput alloc] init];
	[input setProjectKey:projectKey];
	[input setIssueTypeId:issueTypeId];
	return input;
}

+ (MNSIssueInput *)createWithProjectKey:(NSString *)projectKey issueTypeId:(NSString *)issueTypeId summary:(NSString *)summary {
	MNSIssueInput *input = [MNSIssueInput createWithProjectKey:projectKey issueTypeId:issueTypeId];
	[input setSummary:summary];
	return input;
}

#pragma mark instance

- (void)setProjectKey:(NSString *)key {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:key forKey:@"key"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"project"]];
}

- (void)setProject:(MNSBasicProject *)project {
	[self setProjectKey:project.key];
}

- (void)setIssueTypeId:(NSString *)issueTypeId {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:issueTypeId forKey:@"id"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"issuetype"]];
}

- (void)setIssueType:(MNSIssueType *)issueType {
	[self setIssueTypeId:issueType.identifier];
}

- (void)setSummary:(NSString *)summary {
	[self setFieldInput:[MNSFieldInput createWithValue:summary forId:@"summary"]];
}

- (void)setAssigneeName:(NSString *)name {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:name forKey:@"name"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"assignee"]];
}

- (void)setAssignee:(MNSBasicUser *)asignee {
	[self setAssigneeName:asignee.name];
}

- (void)setDescription:(NSString *)description {
	[self setFieldInput:[MNSFieldInput createWithValue:description forId:@"description"]];
}

- (void)setAffectedVersions:(NSArray *)versionsArray {
	if ([self allObjectsOfArray:versionsArray areKindOfClass:[MNSVersion class]]) {
		NSMutableArray *namesVersions = [[NSMutableArray alloc] init];

		for (MNSVersion *thisVersion in versionsArray)
			[namesVersions addObject:thisVersion.name];

		[self setAffectedVersionsNames:namesVersions];
	}
	else {
		NSLog(@"Objects must be versionsDto class");
	}
}

- (void)setAffectedVersionsNames:(NSArray *)namesArray {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithArray:namesArray];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"versions"]];
}

- (void)setComponent:(MNSBasicComponent *)basicComponent {
	[self setComponents:[NSArray arrayWithObject:basicComponent]];
}

- (void)setComponents:(NSArray *)basicComponents {
	if ([self allObjectsOfArray:basicComponents areKindOfClass:[MNSBasicComponent class]]) {
		NSMutableArray *arrayOfComponentsNames = [[NSMutableArray alloc] init];
		for (MNSBasicComponent *component in basicComponents)
			[arrayOfComponentsNames addObject:component.name];
		[self setComponentNames:arrayOfComponentsNames];
	}
	else {
		NSLog(@"Objects must be MNSBasicComponent class");
	}
}

- (void)setComponentName:(NSString *)componentName {
	[self setComponentNames:[NSArray arrayWithObject:componentName]];
}

- (void)setComponentNames:(NSArray *)componentsNames {
	NSMutableArray *componentsByNames = [[NSMutableArray alloc] init];
	for (NSString *name in componentsNames)
		[componentsByNames addObject:[MNSComplexIssueInputFieldValue createWithValue:name forKey:@"id"]];

	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithArray:componentsByNames];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"components"]];
}

- (void)setFixVersions:(NSArray *)versionsArray {
	if ([self allObjectsOfArray:versionsArray areKindOfClass:[MNSVersion class]]) {
		NSMutableArray *namesFixVersions = [[NSMutableArray alloc] init];
		for (MNSVersion *thisVersion in versionsArray)
			[namesFixVersions addObject:thisVersion.name];
		[self setFixVersionsNames:namesFixVersions];
	}
	else {
		NSLog(@"Objects must be versionsDto class");
	}
}

- (void)setFixVersionsNames:(NSArray *)namesArray {
	NSMutableArray *fixVersionsByNames = [[NSMutableArray alloc] init];
	for (NSString *name in namesArray)
		[fixVersionsByNames addObject:[MNSComplexIssueInputFieldValue createWithValue:name forKey:@"id"]];

	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithArray:fixVersionsByNames];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"fixVersions"]];
}

- (void)setDueDate:(NSDate *)dueDate {
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"YYYY-MM-dd"];
	[self setFieldInput:[MNSFieldInput createWithValue:[df stringFromDate:dueDate] forId:@"duedate"]];
}

- (void)setPriority:(MNSBasicPriority *)priority {
	[self setPriorityId:priority.identifier];
}

- (void)setPriorityId:(NSString *)identifier {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:identifier forKey:@"id"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"priority"]];
}

- (void)setOriginalEstimate:(NSString *)originalEstimate {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:originalEstimate forKey:@"originalEstimate"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"timetracking"]];
}

- (void)setReporter:(MNSBasicUser *)basicUser {
	[self setReporterName:basicUser.name];
}

- (void)setReporterName:(NSString *)name {
	MNSComplexIssueInputFieldValue *complexField = [MNSComplexIssueInputFieldValue createWithValue:name forKey:@"name"];
	[self setFieldInput:[MNSFieldInput createWithValue:complexField forId:@"reporter"]];
}

#pragma mark setFields

- (void)setFieldInput:(MNSFieldInput *)fieldInput {
	[_fields setObject:fieldInput forKey:fieldInput.getId];
}

- (MNSFieldInput *)fieldForId:(NSString *)key {
	return [_fields objectForKey:key];
}

- (NSDictionary *)dictionaryVersion {
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	for (MNSFieldInput *thisField in[_fields allValues]) {
		NSObject *fieldValue = [thisField getValue];
		if ([fieldValue isKindOfClass:[MNSComplexIssueInputFieldValue class]]) {
			NSObject *object = [(MNSComplexIssueInputFieldValue *)fieldValue generateJSONVersion];
			[dic setObject:object forKey:thisField.getId];
		}
		else if ([fieldValue isKindOfClass:[NSString class]]) {
			[dic setObject:fieldValue forKey:thisField.getId];
		}
		else {
			NSLog(@"input field type not supported");
		}
	}
	return dic;
}

- (BOOL)allObjectsOfArray:(NSArray *)array areKindOfClass:(Class)className {
	__block BOOL acceptableObjects = TRUE;
	[array enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
	    acceptableObjects = [obj isKindOfClass:[className class]] ? TRUE : FALSE;
	    *stop = !acceptableObjects;
	}];
	return acceptableObjects;
}

@end
