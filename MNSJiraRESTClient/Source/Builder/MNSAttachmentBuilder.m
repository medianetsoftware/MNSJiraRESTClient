//
//  MNSAttachmentBuilder.m
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

#import "MNSAttachmentBuilder.h"
#import "MNSBuilderTools.h"


#import "MNSAttachment.h"
#import "MNSBasicUserbuilder.h"
@implementation MNSAttachmentBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    MNSAttachment* attachment;

    @try {
        
        if(validDictionary(source)){
            attachment = [[MNSAttachment alloc] init];
            attachment.selfUrl = objectFromDicForkey(source, kSelfURL);
            attachment.filename = objectFromDicForkey(source, kFilename);
            if(validDictionary(objectFromDicForkey(source, kAuthor)))
                attachment.author = [MNSBasicUserBuilder
                                     buildWithJSONObject:objectFromDicForkey(source, kAuthor)
                                     error:nil];
            
            attachment.creationDate = [MNSBuilderTools dateFromString:objectFromDicForkey(source, kCreated)];
            
            //        attachment.size = objectFromDicForkey(source, SIZE_ATTACHMENT_JSONPARAM);
            attachment.mimeType = objectFromDicForkey(source, kMimeType);
            
            attachment.contentUrl = objectFromDicForkey(source, kContent);
            
            attachment.thumbnailUrl = objectFromDicForkey(source, kThumbnail);
            
        }
        else {
            *error = [NSError errorWithDomain:@"AttachmentBuilder error" code:0 userInfo:nil];
        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"AttachmentBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return attachment;

    

}

@end
