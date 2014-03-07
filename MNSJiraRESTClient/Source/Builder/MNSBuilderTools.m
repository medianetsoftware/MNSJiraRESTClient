//
//  MNSDTOBuilderTools.m
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

#import "MNSBuilderTools.h"



@implementation MNSBuilderTools

// 2014-01-28T14:28:59.922+0100
+ (NSDate *)dateFromString:(NSString *)dateString {

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS+zzzz"];

	[df setTimeZone:[NSTimeZone systemTimeZone]];
	[df setLocale:[NSLocale systemLocale]];
	return [df dateFromString:dateString];
}

@end
