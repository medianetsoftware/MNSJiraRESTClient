//
//  MNSUserBuilder.m
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
#import "MNSUserBuilder.h"
#import "MNSBasicUserBuilder.h"
#import "MNSUser.h"
#import "MNSExpandablePropertyBuilder.h"



@implementation MNSUserBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError **)error{
	
	NSDictionary *sourceDic = validDictionary(source);
	NSArray *sourceArr = validArray(source);
	
	id returnValue;
	
	if (sourceDic){
		returnValue = [self getUserDTO:sourceDic error:error];
	}
	else if (sourceArr){
		returnValue = [self getArrayWithUsers:sourceArr error:error];
	}
	
	return returnValue;
}

+(MNSUser *)getUserDTO:(NSDictionary *)sourceDic error:(NSError **)error {
	MNSUser *user;
	
	@try {
		MNSBasicUser *basicUser = [MNSBasicUserBuilder buildWithJSONObject:sourceDic error:error];
		
		NSString *timeZone = objectFromDicForkey(sourceDic, kTimeZone);
		NSString *emailAddress = objectFromDicForkey(sourceDic, kEmailAddress);
		NSDictionary *avatarURLs = validDictionaryForKey(sourceDic, kAvatarURLs);
		user = [[MNSUser alloc] initWithUrl:basicUser.selfUrl name:basicUser.name displayName:basicUser.displayName];
		user.timeZone = timeZone;
		user.emailAddress =  emailAddress;
		user.avatarURLs = avatarURLs;
		NSDictionary *groupsDictionary = validDictionaryForKey(sourceDic, kGroups);
		if (groupsDictionary) {
			MNSExpandableProperty *groups = [MNSExpandablePropertyBuilder buildWithJSONObject:groupsDictionary error:error keyString:kExpandablePropertyKeyString];
			user.groups = groups;
		}
	}
	@catch (NSException *exception) {
		*error = [NSError errorWithDomain:@"UserBuilder error:Exception" code:0 userInfo:nil];
		
	}
	
	return user;
	
}

+ (NSMutableArray *)getArrayWithUsers:(NSArray *)usersSource error:(NSError **)error {
	NSMutableArray *assignableUsers = [NSMutableArray new];
	@try {
		for (NSDictionary *jsonUser in usersSource) {
			MNSUser *user = [self getUserDTO:jsonUser error:error];
			if (user) {
				[assignableUsers addObject:user];
			}
		}
	}
	@catch (NSException *exception) {
		*error = [NSError errorWithDomain:@"UserBuilder error:Exception" code:0 userInfo:nil];
	}
	return assignableUsers;
}

@end
