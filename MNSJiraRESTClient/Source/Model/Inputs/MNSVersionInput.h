//
//  MNSVersionInput.h
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

@interface MNSVersionInput : NSObject

@property (nonatomic, strong) NSString *projectKey;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic) BOOL isArchived;
@property (nonatomic) BOOL isReleased;


- (id)initWithProjectKey:(NSString *)projectKey description:(NSString *)description name:(NSString *)name isArchived:(BOOL)isArchived isReleased:(BOOL)isReleased releaseDate:(NSDate *)releaseDate;

- (NSDictionary *)dicToSend;


@end
