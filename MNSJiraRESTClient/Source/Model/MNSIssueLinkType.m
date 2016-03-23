//
//  MNSIssueLinkType.m
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
#import "MNSIssueLinkType.h"

static NSString *const kOutbound = @"OUTBOUND";
static NSString *const kInbound = @"INBOUND";

@implementation MNSIssueLinkType

@synthesize description = _description;

- (id)initWithName:(NSString *)name description:(NSString *)description direction:(enum MNSIssueLinkTypeDirection)direction {
	self = [super init];
	if (self) {
		self.name = name;
		self.description = description;
		self.direction = direction;
	}
	return self;
}

+ (enum MNSIssueLinkTypeDirection)directionWithString:(NSString *)directionString {
	enum MNSIssueLinkTypeDirection issueLinkTypeDirection;
	if ([directionString isEqualToString:kOutbound]) {
		issueLinkTypeDirection = MNSIssueLinkTypeDirectionOutbound;
	}
	else if ([directionString isEqualToString:kInbound]) {
		issueLinkTypeDirection = MNSIssueLinkTypeDirectionInbound;
	}
	else {
		issueLinkTypeDirection = MNSIssueLinkTypeDirectionUnknown;
	}
	return issueLinkTypeDirection;
}

@end
