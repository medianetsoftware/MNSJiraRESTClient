//
//  MNSWorklog.h
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
#import "MNSAddressableNamedEntity.h"
#import "MNSBasicUser.h"
#import "MNSVisibility.h"

@interface MNSWorklog : NSObject <MNSAddressable>

@property (copy, nonatomic) NSString *selfUrl;
@property (copy, nonatomic) NSString *issueUri;
@property (strong, nonatomic) MNSBasicUser *author;
@property (strong, nonatomic) MNSBasicUser *updateAuthor;
@property (copy, nonatomic) NSString *comment;
@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSDate *updateDate;
@property (strong, nonatomic) NSDate *startDate;
@property (assign, nonatomic) NSInteger minutesSpent;
@property (strong, nonatomic) MNSVisibility *visibility;

@end
