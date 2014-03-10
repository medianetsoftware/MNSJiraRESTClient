//
//  MNSSessionBuilder.m
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

#import "MNSSessionBuilder.h"
#import "MNSSession.h"

@implementation MNSSessionBuilder

+(id)buildWithJSONObject:(id)source error:(NSError *__autoreleasing *)error{
    
    MNSSession *session;

    @try {
        
        
        if (validDictionary(source)) {
            
             session = [[MNSSession alloc] init];
            
            session.loginInfo.loginCount = [[[source objectForKey:kLoginInfo] objectForKey:kLoginCount]intValue];
            session.loginInfo.previousLoginDate = [[source objectForKey:kLoginInfo] objectForKey:kPreviousLoginTime];
            
            session.username = [source objectForKey:kName];
            session.userUrl = [source objectForKey:kSelfURL];
            
            
        } else {
            *error = [NSError errorWithDomain:@"SessionBuilder error" code:0 userInfo:nil];
        }
        

    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"SessionBuilder error:Exception" code:0 userInfo:nil];

    }
    
    return session;

    
    
}

@end
