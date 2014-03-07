//
//  MNSComponentInputWithProjectKey.m
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
#import "MNSComponentInputWithProjectKey.h"

@implementation MNSComponentInputWithProjectKey

- (id)initWithProjectKey:(NSString *)projectKey name:(NSString *)name description:(NSString *)description leadUserName:(NSString *)leadUserName assigneeType:(AssigneeType)assigneeType {
	self = [super initWithName:name description:description leadUsername:leadUserName assigneetype:assigneeType];

	if (self) {
		_projectKey = projectKey;
	}
	return self;
}

- (id)initWithProjectKey:(NSString *)projectKey componentType:(MNSComponentInput *)componentType {
	self = [super initWithName:componentType.name description:componentType.description leadUsername:componentType.leadUsername assigneetype:componentType.assigneeType];

	if (self) {
		_projectKey = projectKey;
	}
	return self;
}

- (NSDictionary *)dicToSend {
	@try {
		NSString *assigneeTypeStr;

		switch (self.assigneeType) {
			case PROJECT_DEFAULT:
				assigneeTypeStr = @"PROJECT_DEFAULT";
				break;

			case COMPONENT_LEAD:
				assigneeTypeStr = @"COMPONENT_LEAD";
				break;

			case PROJECT_LEAD:
				assigneeTypeStr = @"PROJECT_LEAD";
				break;

			case UNASSIGNED:
				assigneeTypeStr = @"UNASSIGNED";
				break;

			default:
				NSLog(@"Unexpected assignee type!!!!!!!");
				break;
		}
		NSDictionary *dic;
		if ([_projectKey length] > 0)
			dic = @{ @"project": _projectKey, @"name":self.name, @"description":self.description ? self.description : @"", @"leadUserName":self.leadUsername ? self.leadUsername : @"", @"assigneeType":assigneeTypeStr };
		else
			dic = @{ @"name":self.name, @"description":self.description ? self.description : @"", @"leadUserName":self.leadUsername ? self.leadUsername : @"", @"assigneeType":assigneeTypeStr };


		return dic;
	}
	@catch (NSException *exception)
	{
		@throw([NSException exceptionWithName:@"Check the AssigneeType and/or the name of the component" reason:nil userInfo:nil]);
	}
}

@end
