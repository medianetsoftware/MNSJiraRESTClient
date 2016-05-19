//
//  MNSDTOBuilder.h
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

#define objectFromDicForkey(dic, key) [(NSDictionary *)dic objectForKey : key]

#define validDictionary(dic) (dic && [dic isKindOfClass:[NSDictionary class]] && ((NSDictionary *)dic).count > 0) ? (NSDictionary *)dic : nil
#define validArray(arr) (arr && [arr isKindOfClass:[NSArray class]] && ((NSArray *)arr).count > 0) ? (NSArray *)arr : nil
#define validString(str) (str && [str isKindOfClass:[NSString class]]) ? (NSString *)str : nil

#define validDictionaryForKey(dic, key) validDictionary(objectFromDicForkey(dic, key))
#define validArrayForKey(dic, key) validArray(objectFromDicForkey(dic, key))
#define validStringForkey(dic, key) validString(objectFromDicForkey(dic, key))

@protocol MNSBuilder <NSObject>

+ (id)buildWithJSONObject:(id)source error:(NSError **)error;

@end
