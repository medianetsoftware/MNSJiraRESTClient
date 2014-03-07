//
//  MNSExpandablePropertyBuilder.m
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

#import "MNSExpandablePropertyBuilder.h"
#import "MNSExpandableProperty.h"



@implementation MNSExpandablePropertyBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError**)error {
    MNSExpandableProperty *expandablePropertyDTO;

    @try {
        if (validDictionary(source)){
            NSNumber *sizeNumber = objectFromDicForkey(source, kSize);
            NSArray *items = objectFromDicForkey(source, kItems);
            
            expandablePropertyDTO = [[MNSExpandableProperty alloc] initWithSize:[sizeNumber integerValue] items:items];
            
        }
        else {
            *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error" code:0 userInfo:nil];
        }
        
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error:Exception" code:0 userInfo:nil];

    }
    return expandablePropertyDTO;

    
}

+ (id)buildWithJSONObject:(id)source error:(NSError**)error keyString:(NSString*)keyString {
    MNSExpandableProperty *expandablePropertyDTO;

    @try {
        
        if (validDictionary(source)){
            
            NSNumber *sizeNumber = objectFromDicForkey(source, kSize);
            NSArray *itemsUnparsed = objectFromDicForkey(source, kItems);
            NSMutableArray *items = [NSMutableArray array];
            for (id itemUnparsed in itemsUnparsed) {
                NSString *string = objectFromDicForkey(itemUnparsed, keyString);
                [items addObject:string];
            }
            
            expandablePropertyDTO = [[MNSExpandableProperty alloc] initWithSize:[sizeNumber integerValue] items:items];
            
        }
        else {
            *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error" code:1 userInfo:nil];
        }


    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error:Exception" code:1 userInfo:nil];

    }
    
    return expandablePropertyDTO;

    
}

+ (id)buildWithJSONObject:(id)source error:(NSError**)error itemBuilderClass:(Class<MNSBuilder>)itemBuilderClass {
    MNSExpandableProperty *expandablePropertyDTO;

    @try {
        if (validDictionary(source)){
            
            NSNumber *sizeNumber = objectFromDicForkey(source, kSize);
            NSArray *itemsUnparsed = objectFromDicForkey(source, kItems);
            NSMutableArray *items = [NSMutableArray array];
            for (id itemUnparsed in itemsUnparsed) {
                [items addObject:[itemBuilderClass buildWithJSONObject:itemUnparsed error:error]];
            }
            
            expandablePropertyDTO = [[MNSExpandableProperty alloc] initWithSize:[sizeNumber integerValue] items:items];

            
        }
        else {
            *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error" code:2 userInfo:nil];
        }


    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ExpandablePropertyBuilder error:Exception" code:2 userInfo:nil];

    }
    
    return expandablePropertyDTO;

    
}

@end
