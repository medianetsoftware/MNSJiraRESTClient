//
//  MNSServerInfo.h
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

@interface MNSServerInfo : NSObject

@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *buildNumber;
@property (nonatomic, retain) NSDate *buildDate;
@property (nonatomic, retain) NSDate *serverTime;
@property (nonatomic, retain) NSString *scmInfo;
@property (nonatomic, retain) NSString *serverTitle;


- (id)initWithBaseUrl:(NSString *)baseurl version:(NSString *)version buildNumber:(NSString *)buildNumber buildDate:(NSDate *)buildDate serverTime:(NSDate *)serverTime scmInfo:(NSString *)scmInfo serverTitle:(NSString *)serverTitle;

@end
