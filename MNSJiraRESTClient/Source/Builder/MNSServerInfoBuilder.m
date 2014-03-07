//
//  MNSServerInfoBuilder.m
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

#import "MNSServerInfoBuilder.h"
#import "MNSServerInfo.h"
#import "MNSBuilderTools.h"

@implementation MNSServerInfoBuilder





+ (id) buildWithJSONObject:(id)source error:(NSError **)error {
    MNSServerInfo *serverInfo;

    @try {
        if (validDictionary(source)) {
            serverInfo = [[MNSServerInfo alloc] initWithBaseUrl:[source objectForKey:kBaseUrl] version:[source objectForKey:kVersion] buildNumber:[source objectForKey:kBuildNumber] buildDate:[MNSBuilderTools dateFromString:[source objectForKey:kBuildDate]] serverTime:[MNSBuilderTools dateFromString:[source objectForKey:kServerTime]] scmInfo:[source objectForKey:kSmcInfo] serverTitle:[source objectForKey:kServerTitle]];
            
        }else {
            *error = [NSError errorWithDomain:@"ServerInfo error" code:0 userInfo:nil];

        }

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"ServerInfo error:Exception" code:0 userInfo:nil];

    }
    
    return serverInfo;


   
}

@end
