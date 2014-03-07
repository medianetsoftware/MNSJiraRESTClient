//
//  MNSVersionRestClient.m
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

#import "MNSVersionRestClient.h"
#import "MNSVersionBuilder.h"
#import "MNSVersionRelatedIssuesCount.h"

@implementation MNSVersionRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticato{
    self = [super initWithBaseUri:baseUri authenticator:autheticato];
    if (self){
        _versionRootUrl = [NSString stringWithFormat:@"%@/%@", baseUri, @"version"];
    }
    return self;
}

- (void)getVersionWithUrl:(NSString*)versionUrl Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
        [self getUrl:versionUrl success:^(id response) {
            
            NSError*error;
            
            MNSVersion *version =  [MNSVersionBuilder buildWithJSONObject:response error:&error];

            if (success && [error.domain length] == 0) {
                success(version);
            }
            else{
                if(fail)
                    fail(error);
            }
            
            
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
   
}

- (void)createVersion:(MNSVersionInput *)versionInput Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
        [self postUrl:_versionRootUrl bodyJSONObject:[versionInput dicToSend] success:^(NSDictionary *response) {
            NSError*error;
            MNSVersion *version =  [MNSVersionBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(version);
            }
            else{
                if(fail)
                    fail(error);
            }
            
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];

}

- (void)updateVersion:(NSString *)versionUrl versionInput:(MNSVersionInput *)versionInput Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
        [self putUrl:versionUrl bodyJSONObject:[versionInput dicToSend] success:^(NSDictionary *response) {
            NSError*error;
            MNSVersion *version =  [MNSVersionBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(version);
            }
            else{
                if(fail)
                    fail(error);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
}

- (void)removeVersion:(NSString *)versionUrl urlmoveFixIssuesToVersionUri:(NSString *)moveFixIssuesToVersionUri urlmoveAffectedIssuesToVersionUri:(NSString *)moveAffectedIssuesToVersionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    
    @try {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (moveFixIssuesToVersionUri){
            [dic setObject:moveFixIssuesToVersionUri forKey:@"moveFixIssuesTo"];
        }
        
        if (moveAffectedIssuesToVersionUri){
            [dic setObject:moveAffectedIssuesToVersionUri forKey:@"moveAffectedIssuesTo"];
        }
        
        
        [self deleteUrl:versionUrl  parametersInURL: [[dic allKeys] count]>0 ? dic:nil success:^(NSDictionary *response) {
            if (success) {
                success(response);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];

    }
    @catch (NSException *exception) {
        if (fail) {
            NSError * error = [[NSError alloc] initWithDomain:exception.name code:666 userInfo:nil];
            fail(error);
        }
    }
}

- (void)getVersionRelatedIssuesCount:(NSString *)versionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    
    @try {
        NSString *relatedIssueCountsUri = [NSString stringWithFormat:@"%@/relatedIssueCounts",versionUri];
        [self getUrl:relatedIssueCountsUri success:^(id response) {
            if (success) {
                success([[MNSVersionRelatedIssuesCount alloc] initWithNumFixedIssues:[[response objectForKey:@"issuesFixedCount"] intValue] numAffectedIssues:[[response objectForKey:@"issuesAffectedCount"] intValue]]);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    }
    @catch (NSException *exception) {
        if (fail) {
            NSError * error = [[NSError alloc] initWithDomain:exception.name code:666 userInfo:nil];
            fail(error);
        }
    }
}

- (void)getNumUnresolvedIssues:(NSString *)versionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    @try {
        NSString *relatedIssueCountsUri = [NSString stringWithFormat:@"%@/unresolvedIssueCount",versionUri];
        [self getUrl:relatedIssueCountsUri success:^(id response) {
            if (success) {
                success([response objectForKey:@"issuesUnresolvedCount"]);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    }
    @catch (NSException *exception) {
        if (fail) {
            NSError * error = [[NSError alloc] initWithDomain:exception.name code:666 userInfo:nil];
            fail(error);
        }
    }
}


- (void)moveVersionAfter:(NSString *)versionUrl afterVersionUrl:(NSString *)afterVersionUri Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    @try {
        NSString *moveURL = [self getMoveVersionUri:versionUrl];
        
        [self postUrl:moveURL bodyJSONObject:@{@"after": afterVersionUri} success:^(id response) {
            NSError*error;
            MNSVersion *version =  [MNSVersionBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(version);
            }
            else{
                if(fail)
                    fail(error);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];
    }
    @catch (NSException *exception) {
        if (fail) {
            NSError * error = [[NSError alloc] initWithDomain:exception.name code:666 userInfo:nil];
            fail(error);
        }
    }
}

- (void)moveVersion:(NSString *)versionUrl position:(VersionPosition)versionPosition Success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail{
    
    @try {
        NSString *moveURL = [self getMoveVersionUri:versionUrl];
        
        NSString * versionPositionStr;
        
        switch (versionPosition) {
            case FIRST:
                versionPositionStr = @"First";
                break;
            case LAST:
                versionPositionStr = @"Last";
                break;
            case EARLIER:
                versionPositionStr = @"Earlier";
                break;
            case LATER:
                versionPositionStr = @"Later";
                break;
            default:
                NSLog(@"Unexpected version Position!!!!!!!");
                break;
        }
        
        
        [self postUrl:moveURL bodyJSONObject:@{@"position": versionPositionStr} success:^(id response) {
            NSError*error;
            MNSVersion *version =  [MNSVersionBuilder buildWithJSONObject:response error:&error];
            
            if (success && [error.domain length] == 0) {
                success(version);
            }
            else{
                if(fail)
                    fail(error);
            }
        } fail:^(NSError *error) {
            if (fail) {
                fail(error);
            }
        }];

    }
    @catch (NSException *exception) {
        if (fail) {
            NSError * error = [[NSError alloc] initWithDomain:exception.name code:666 userInfo:nil];
            fail(error);
        }
    }
    
}


- (NSString*)getMoveVersionUri:(NSString *)versionUrl{
    return [NSString stringWithFormat:@"%@/move", versionUrl];
}

@end

