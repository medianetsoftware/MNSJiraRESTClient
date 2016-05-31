//
//  MNSTransition.h
//  MNSJiraRESTClient
//
//  Created by Juan Navas on 30/5/16.
//  Copyright © 2016 Medianet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNSAddressableNamedEntity.h"
#import "MNSStatus.h"

@interface MNSTransition : NSObject <MNSNamed, MNSIdentifiable>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) MNSStatus *to;

@end
