//
//  MNSCommentBuilder.m
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

#import "MNSCommentBuilder.h"

#import "MNSComment.h"
#import "MNSBasicUserBuilder.h"
#import "MNSVisibility.h"
#import "MNSBuilderTools.h"


@implementation MNSCommentBuilder



+(id)buildWithJSONObject:(id)source error:(NSError **)error{
    MNSComment* comment;

    @try {
        if(validDictionary(source)){
            comment = [[MNSComment alloc] init];
            comment.selfUrl = objectFromDicForkey(source, kSelfURL);
            comment.identifier = objectFromDicForkey(source, kID);
            comment.body = objectFromDicForkey(source, kBody);
            comment.author = [MNSBasicUserBuilder buildWithJSONObject:objectFromDicForkey(source, kAuthor) error:error];
            comment.updateAuthor = [MNSBasicUserBuilder buildWithJSONObject:objectFromDicForkey(source, kUpdateAuthor) error:error];
            
            comment.creationDate =  [MNSBuilderTools dateFromString:objectFromDicForkey(source, kCreated)];
            comment.updateDate =  [MNSBuilderTools dateFromString:objectFromDicForkey(source, kUpdateDate)];
            
            
            NSDictionary* visibilityDic = objectFromDicForkey(source, kVisibility);
            comment.visibility = [MNSVisibility createWithVisibility:objectFromDicForkey(visibilityDic, kType)
                                                               value:objectFromDicForkey(visibilityDic, kValue)];
            
        }
        else {
            *error = [NSError errorWithDomain:@"CommentBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"CommentBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return comment;

    
}

@end
