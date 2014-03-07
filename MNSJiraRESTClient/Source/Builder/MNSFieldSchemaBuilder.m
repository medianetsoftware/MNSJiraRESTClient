//
//  MNSFieldSchemaBuilder.m
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

#import "MNSFieldSchemaBuilder.h"
#import "MNSFieldSchema.h"

@implementation MNSFieldSchemaBuilder


+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    
    MNSFieldSchema *fieldSchema;

    @try {
        if (validDictionary(source)) {
            fieldSchema = [[MNSFieldSchema alloc] init];
            
            
            if (objectFromDicForkey(source, kType))
                fieldSchema.type = objectFromDicForkey(source, kType);
            
            if (objectFromDicForkey(source, kItems))
                fieldSchema.items = objectFromDicForkey(source, kItems);
            
            if (objectFromDicForkey(source, kSystem))
                fieldSchema.system = objectFromDicForkey(source, kSystem);
            
            if (objectFromDicForkey(source, kCustomId))
                fieldSchema.customId = objectFromDicForkey(source, kCustomId);
            
        }else {
            *error = [NSError errorWithDomain:@"FieldSchemaBuilder error" code:0 userInfo:nil];

        }
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"FieldSchemaBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return fieldSchema;

}

@end
