//
//  MNSChangelogItem.h
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

#import "MNSField.h"

@interface MNSChangelogItem : NSObject

@property (assign, nonatomic) Fieldtype fieldType;
@property (copy, nonatomic) NSString *field;
@property (copy, nonatomic) NSString *from;
@property (copy, nonatomic) NSString *fromString;
@property (copy, nonatomic) NSString *to;
@property (copy, nonatomic) NSString *toString;

- (id)initWithFieldType:(Fieldtype)fieldType field:(NSString *)field from:(NSString *)from fromString:(NSString *)fromString to:(NSString *)to toString:(NSString *)toString;

@end
