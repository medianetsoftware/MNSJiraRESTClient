//
//  MNSVersionInput.m
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

#import "MNSVersionInput.h"

@implementation MNSVersionInput


- (id)initWithProjectKey:(NSString *)projectKey description:(NSString *)description name:(NSString *)name isArchived:(BOOL)isArchived isReleased:(BOOL)isReleased releaseDate:(NSDate *)releaseDate {
	self = [super init];

	if (self) {
		self.projectKey = projectKey;
		self.description = description;
		self.isArchived = isArchived;
		self.isReleased = isReleased;
		self.releaseDate = releaseDate;
		self.name = name;
	}
	return self;
}

- (NSDictionary *)dicToSend {
	@try {
		NSDictionary *dic;

		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd"];

		NSString *dateInString = [formatter stringFromDate:self.releaseDate];
		NSString *isArchivedString;
		NSString *isReleasedString;


		if (self.isArchived)
			isArchivedString = @"true";
		else
			isArchivedString = @"false";

		if (self.isReleased)
			isReleasedString = @"true";
		else
			isReleasedString = @"false";

		dic = @{ @"project": _projectKey, @"name":self.name, @"description":self.description ? self.description : @"", @"archived":isArchivedString, @"released":isReleasedString, @"releaseDate" : dateInString ? dateInString : @"" };

		return dic;
	}
	@catch (NSException *exception)
	{
		@throw([NSException exceptionWithName:@"Check the projectKey and/or the name of the version" reason:nil userInfo:nil]);
	}
}

@end
