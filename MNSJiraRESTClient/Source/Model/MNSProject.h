//
//  MNSProjectDto.h
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

#import "MNSBasicProject.h"
#import "MNSComponentInput.h"
#import "MNSBasicUser.h"
#import "MNSBasicProject.h"

@interface MNSProject : MNSBasicProject

@property (nonatomic) AssigneeType assigneeType;
@property (nonatomic, strong) NSDictionary *avatarUrls;
@property (nonatomic, strong) NSArray *components;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *expand;
@property (nonatomic) long identifier;
@property (nonatomic, strong) NSArray *issueTypes;
@property (nonatomic, strong) MNSBasicUser *lead;
@property (nonatomic, strong) NSArray *roles;
@property (nonatomic, strong) NSArray *versions;



@end
