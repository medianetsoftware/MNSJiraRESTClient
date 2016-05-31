//
//  MNSTransitionBuilder.m
//  MNSJiraRESTClient
//
//  Created by Juan Navas on 30/5/16.
//  Copyright © 2016 Medianet. All rights reserved.
//

#import "MNSTransitionBuilder.h"
#import "MNSTransition.h"
#import "MNSStatusBuilder.h"

@implementation MNSTransitionBuilder

+ (id)buildWithJSONObject:(id)source error:(NSError **)error{
	
	NSDictionary *sourceDic = validDictionary(source);
	NSArray *sourceArr = validArray(source);
	
	id returnValue;
	
	if (sourceDic){
		returnValue = [self getTransitionDTO:sourceDic error:error];
	}
	else if (sourceArr){
		returnValue = [self getArrayWithTransitions:sourceArr error:error];
	}
	
	return returnValue;
}

+(MNSTransition *) getTransitionDTO:(NSDictionary *)dictionary error:(NSError **)error {
	MNSTransition *transition;
	@try {
		
		if (validDictionary(dictionary)) {
			transition = [[MNSTransition alloc] init];
			transition.name = objectFromDicForkey(dictionary, kName);
			transition.identifier = objectFromDicForkey(dictionary, kId);
			if (validDictionaryForKey(dictionary, kTo)) {
				MNSStatus *to = [MNSStatusBuilder buildWithJSONObject:objectFromDicForkey(dictionary, kTo) error:error];
				transition.to = to;
			}
			
			
		}else {
			*error = [NSError errorWithDomain:@"TransitionBuilder error" code:0 userInfo:nil];
			
		}
		
	}
	@catch (NSException *exception) {
		*error = [NSError errorWithDomain:@"TransitionBuilder error:Exception" code:0 userInfo:nil];
		
	}
	return transition;
}

+ (NSMutableArray *)getArrayWithTransitions:(NSArray *)transitionsArray error:(NSError **)error {
	NSMutableArray *transitions = [NSMutableArray new];
	@try {
		for (NSDictionary *jsonTransition in transitionsArray) {
			MNSTransition *transition = [self getTransitionDTO:jsonTransition error:error];
			if (transition) {
				[transitions addObject:transition];
			}
		}
	}
	@catch (NSException *exception) {
		*error = [NSError errorWithDomain:@"TransitionBuilder error:Exception" code:0 userInfo:nil];
	}
	return transitions;
}

@end
