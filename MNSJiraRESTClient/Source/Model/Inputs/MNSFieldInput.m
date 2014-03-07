//
//  MNSFieldInput.m
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


@interface MNSFieldInput () {
	NSString *_key;
	NSObject *_value;
}

@end

@implementation MNSFieldInput

+ (MNSFieldInput *)createWithValue:(NSObject *)object forId:(NSString *)key {
	return [[MNSFieldInput alloc] initWithValue:object forId:key];
}

- (id)initWithValue:(NSObject *)object forId:(NSString *)key {
	self = [super init];
	if (self) {
		_key = key;
		_value = object;
	}
	return self;
}

- (id)initWithValue:(NSObject *)object forField:(MNSFieldInput *)field {
	self = [super init];
	if (self) {
		_key = field.getId;
		_value = object;
	}
	return self;
}

- (NSString *)getId {
	return _key;
}

- (NSObject *)getValue {
	return _value;
}

@end
