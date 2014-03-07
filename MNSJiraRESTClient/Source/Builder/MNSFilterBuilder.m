//
//  MNSFilterBuilder.m
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

#import "MNSFilterBuilder.h"
#import "MNSFilter.h"
#import "MNSBasicUserBuilder.h"



@implementation MNSFilterBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError**)error {
    MNSFilter *filterDTO;

    @try {
        
        
        if (validDictionary(source)){
            
            NSString *selfUri = objectFromDicForkey(source, kSelfURL);
            NSString *ID = objectFromDicForkey(source, kID);
            NSString *name = objectFromDicForkey(source, kName);
            NSString *jql = objectFromDicForkey(source, kJQL);
            NSString *description = objectFromDicForkey(source, kDescription);
            NSString *searchUrl = objectFromDicForkey(source, kSearchUrl);
            NSString *viewUrl = objectFromDicForkey(source, kViewUrl);
            NSDictionary *basicUserJSONDictionary = objectFromDicForkey(source, kOwner);
            MNSBasicUser *owner = [MNSBasicUserBuilder buildWithJSONObject:basicUserJSONDictionary error:error];
            NSNumber *favourite = objectFromDicForkey(source, kFavourite);
            
            filterDTO = [[MNSFilter alloc] initWithUrl:selfUri name:name];
            filterDTO.ID = ID;
            filterDTO.jql = jql;
            filterDTO.description = description;
            filterDTO.searchUrl = searchUrl;
            filterDTO.viewUrl = viewUrl;
            filterDTO.owner = owner;;
            filterDTO.favourite = [favourite boolValue];
            
        }
        else {
            *error = [NSError errorWithDomain:@"FilterBuilder error" code:0 userInfo:nil];
        }
        
        

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"FilterBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return filterDTO;

    
}

@end
