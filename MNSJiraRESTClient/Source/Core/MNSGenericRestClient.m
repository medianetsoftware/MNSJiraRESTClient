//
//  MNSGenericRestClient.m
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
#import "MNSGenericRestClient.h"

@implementation MNSGenericRestClient

- (id)initWithBaseUri:(NSString *)baseUri authenticator:(MNSRequestAuthenticator *)autheticator {
	self = [super init];
	if (self) {
		_baseUri = baseUri;
		
		_manager = [AFHTTPSessionManager manager];
		
		_requestSerializer = [AFJSONRequestSerializer serializer];
		[_requestSerializer setAuthorizationHeaderFieldWithUsername:autheticator.username password:autheticator.password];
		_manager.requestSerializer = _requestSerializer;
	}
	return self;
}

#pragma mark - GET

- (void)getUrl:(NSString *)urlString success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self getUrl:urlString parametersInURL:nil success:success fail:fail];
}

- (void)getUrl:(NSString *)urlString parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self doRequestWithURLString:urlString actionVerb:@"GET" body:nil parametersInURL:parametersInURL success: ^(NSURLSessionTask *operation, id response) {
		success(response);
	} failure: ^(NSURLSessionTask *operation, NSError *error) {
		fail(error);
	}];
}

#pragma mark - POST

- (void)postUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self postUrl:urlString bodyJSONObject:bodyJSONObject parametersInURL:nil success:success fail:fail];
}

- (void)postUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	NSError *jsonError;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyJSONObject options:kNilOptions error:&jsonError];
	if (jsonError == nil) {
		[self doRequestWithURLString:urlString actionVerb:@"POST" body:jsonData parametersInURL:parametersInURL success: ^(NSURLSessionTask *operation, id response) {
			success(response);
		} failure: ^(NSURLSessionTask *operation, NSError *error) {
			fail(error);
		}];
	}
	else {
		fail(jsonError);
	}
}

#pragma mark - PUT

- (void)putUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self putUrl:urlString bodyJSONObject:bodyJSONObject parametersInURL:nil success:success fail:fail];
}

- (void)putUrl:(NSString *)urlString bodyJSONObject:(id)bodyJSONObject parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	NSError *jsonError;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyJSONObject options:kNilOptions error:&jsonError];
	if (jsonError == nil) {
		[self doRequestWithURLString:urlString actionVerb:@"PUT" body:jsonData parametersInURL:parametersInURL success: ^(NSURLSessionTask *operation, id response) {
			success(response);
		} failure: ^(NSURLSessionTask *operation, NSError *error) {
			fail(error);
		}];
	}
	else {
		fail(jsonError);
	}
}

#pragma mark - DELETE

- (void)deleteUrl:(NSString *)urlString success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self deleteUrl:urlString parametersInURL:nil success:success fail:fail];
}

- (void)deleteUrl:(NSString *)urlString parametersInURL:(NSDictionary *)parametersInURL success:(MNSRestClientSuccessBlock)success fail:(MNSRestClientFailBlock)fail {
	[self doRequestWithURLString:urlString actionVerb:@"DELETE" body:nil parametersInURL:parametersInURL success: ^(NSURLSessionTask *operation, id response) {
		success(response);
	} failure: ^(NSURLSessionTask *operation, NSError *error) {
		fail(error);
	}];
}

#pragma mark - Private Imp

- (void)doRequestWithURLString:(NSString *)urlString actionVerb:(NSString *)verb body:(NSData *)body parametersInURL:(NSDictionary *)parametersInURL success:(void (^)(NSURLSessionTask *operation, id responseObject))success
					   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
	//parametters should be added in URL
	
	_requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"POST", @"PUT", @"DELETE", nil];
	NSMutableURLRequest *request = [_requestSerializer requestWithMethod:verb URLString:urlString parameters:parametersInURL error:nil];
	
	NSLog(@"%@ to: %@", verb, request.URL.absoluteString);
	
	[request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Encoding"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	
	NSLog(@"REQUEST HEADERS:: %@", [request allHTTPHeaderFields]);
	
	if (body) {
		//AFJSONrequestserializer will not specify content-type beacuse of custom body and parametters added in url
		NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
		[request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:body];
	}
	
	NSURL *url = [NSURL URLWithString:urlString];
	if ([url.scheme isEqualToString:@"https"] && _securityPolicy != nil) {
		[_manager setSecurityPolicy:_securityPolicy];
	}
	
	NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
		
		if(error) {
			failure(dataTask, error);
		} else {
			success(dataTask, responseObject);
		}
	}];
	[dataTask resume];
}

- (void)cleanCookies {
	NSString *urlDomain = @"medianet.atlassian.net";
	for (NSHTTPCookie *cookie in[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
		if ([[cookie domain] rangeOfString:urlDomain].location != NSNotFound) {
			[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
		}
	}
}

@end
