//
//  MNSGetCreateMetadataOptions.h
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

#import <Foundation/Foundation.h>

@interface MNSGetCreateIssueMetadataOptions : NSObject

@property (nonatomic, strong) NSArray *projectIds;
@property (nonatomic, strong) NSArray *projectKeys;
@property (nonatomic, strong) NSArray *issueTypeIds;
@property (nonatomic, strong) NSArray *issueTypeNames;
@property (nonatomic, strong) NSArray *expandos; //list of expandables fields
+ (MNSGetCreateIssueMetadataOptions *)createMetaDataOptionsWithProjectIds:(NSArray *)projectIds
                                                              projectKeys:(NSArray *)projectKeys
                                                             issueTypeIds:(NSArray *)issueTypeIds
                                                           issueTypeNames:(NSArray *)issueTypeNames
                                                                 expandos:(NSArray *)expandos;
@end
