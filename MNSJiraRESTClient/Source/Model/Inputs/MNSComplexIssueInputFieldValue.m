//
//  MNSComplexIssueInputFieldValue.m
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

#import "MNSComplexIssueInputFieldValue.h"

@implementation MNSComplexIssueInputFieldValue


+ (MNSComplexIssueInputFieldValue *)createWithArray:(NSArray *)array {
	MNSComplexIssueInputFieldValue *complexIssueInputFieldValue = [[MNSComplexIssueInputFieldValue alloc] init];
	if (complexIssueInputFieldValue) {
		[complexIssueInputFieldValue setValues:array];
	}
	return complexIssueInputFieldValue;
}

+ (MNSComplexIssueInputFieldValue *)createWithDictionary:(NSDictionary *)dictionary {
	MNSComplexIssueInputFieldValue *complexIssueInputFieldValue = [[MNSComplexIssueInputFieldValue alloc] init];
	if (complexIssueInputFieldValue) {
		[complexIssueInputFieldValue setValues:dictionary];
	}
	return complexIssueInputFieldValue;
}

+ (MNSComplexIssueInputFieldValue *)createWithValue:(NSObject *)value forKey:(NSString *)key {
	return [MNSComplexIssueInputFieldValue createWithDictionary:[NSDictionary dictionaryWithObject:value forKey:key]];
}

- (NSObject *)generateJSONVersion {
	NSObject *JSONVersion = nil;
	if ([_values isKindOfClass:[NSDictionary class]]) {
		JSONVersion = [[NSMutableDictionary alloc] init];

		for (NSString *thisKey in[(NSDictionary *)_values allKeys]) {
			NSObject *fieldValue = [(NSDictionary *)_values objectForKey : thisKey];
			if ([fieldValue isKindOfClass:[MNSComplexIssueInputFieldValue class]]) {
				NSObject *object = [(MNSComplexIssueInputFieldValue *)fieldValue generateJSONVersion];
				[(NSMutableDictionary *)JSONVersion setObject : object forKey : thisKey];
			}
			else {
				[(NSMutableDictionary *)JSONVersion setObject : fieldValue forKey : thisKey];
			}
		}
	}
	else if ([_values isKindOfClass:[NSArray class]]) {
		JSONVersion = [[NSMutableArray alloc] init];
		for (NSObject *thisObject in(NSArray *) _values) {
			if ([thisObject isKindOfClass:[MNSComplexIssueInputFieldValue class]]) {
				NSObject *object = [(MNSComplexIssueInputFieldValue *)thisObject generateJSONVersion];
				[(NSMutableArray *)JSONVersion addObject : object];
			}
			else if ([thisObject isKindOfClass:[NSString class]]) {
				[(NSMutableArray *)JSONVersion addObject : thisObject];
			}
		}
	}

	return JSONVersion;
}

@end
