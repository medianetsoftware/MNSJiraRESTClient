//
//  MNSVisibility.m
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
#import "MNSVisibility.h"

@implementation MNSVisibility

+ (MNSVisibility *)roleAndValue:(NSString *)value {
	return [[MNSVisibility alloc] initWithVisibilityType:ROLE value:value];
}

+ (MNSVisibility *)groupAndValue:(NSString *)value {
	return [[MNSVisibility alloc] initWithVisibilityType:GROUP value:value];
}

- (id)initWithVisibilityType:(eVisibilityType)type value:(NSString *)value {
	self = [super init];
	if (self) {
		_visibilityType = type;
		_value = value;
	}
	return self;
}

+ (MNSVisibility *)createWithVisibility:(NSString *)typeString value:(NSString *)value {
	if ([typeString isEqualToString:@"role"]) {
		return [MNSVisibility roleAndValue:value];
	}
	else if ([typeString isEqualToString:@"group"]) {
		return [MNSVisibility groupAndValue:value];
	}
	else {
		NSLog(@"Visibility type not asigned: %@", typeString);
		return nil;
	}
}

@end
