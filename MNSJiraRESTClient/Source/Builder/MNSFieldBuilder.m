//
//  MNSFieldBuilder.m
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

#import "MNSFieldBuilder.h"
#import "MNSField.h"
#import "MNSFieldSchemaBuilder.h"




@implementation MNSFieldBuilder


+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    
    MNSField *fieldDto;

    @try {
        if (validDictionary(source)) {
            fieldDto = [[MNSField alloc] init];
            fieldDto.identifier = objectFromDicForkey(source, kID);
            fieldDto.name = objectFromDicForkey(source, kName);
            fieldDto.fieldType = objectFromDicForkey(source, kCustom)==0?JIRA:CUSTOM;
            fieldDto.orderable = [objectFromDicForkey(source, kOrderable) boolValue];
            fieldDto.navigable = [objectFromDicForkey(source, kNavigable) boolValue];
            fieldDto.searchable = [objectFromDicForkey(source, kSearcheable) boolValue];
            
            MNSFieldSchema *fieldSchema;
            if (objectFromDicForkey(source, kSchema))
                fieldSchema = [MNSFieldSchemaBuilder buildWithJSONObject:objectFromDicForkey(source, kSchema) error:error];
            fieldDto.schema = fieldSchema;
            
        }else {
            *error = [NSError errorWithDomain:@"FieldBuilder error" code:0 userInfo:nil];
        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"FieldBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return fieldDto;


}

@end
