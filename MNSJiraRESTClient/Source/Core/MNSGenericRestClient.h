//
//  MNSGenericRestClient.h
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

#import <AFNetworking/AFNetworking.h>
#import "MNSRequestAuthenticator.h"


typedef void (^MNSRestClientSuccessBlock)(id response);
typedef void (^MNSRestClientFailBlock)(NSError *error);

@interface MNSGenericRestClient : NSObject {
	AFHTTPSessionManager *_manager;
	AFSecurityPolicy *_securityPolicy;
	AFJSONRequestSerializer *_requestSerializer;
}

@property (nonatomic, copy) NSString *baseUri;

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticator;

- (void)getUrl:(NSString *)urlString success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)getUrl:(NSString *)urlString parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)postUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)postUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)putUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)putUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;

- (void)deleteUrl:(NSString *)urlString success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;
- (void)deleteUrl:(NSString *)urlString parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail;


@end
