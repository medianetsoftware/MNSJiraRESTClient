//
//  MNSTimeTrackingBuilder.m
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

#import "MNSTimeTrackingBuilder.h"
#import "MNSTimeTracking.h"



@implementation MNSTimeTrackingBuilder

+(id)buildWithJSONObject:(id)source error:(NSError **)error {
    MNSTimeTracking *timeTracking;

    @try {
        
        if (validDictionary(source)) {
            NSNumber *originalEstimateSeconds = objectFromDicForkey(source, kOriginalEstimateSeconds);
            NSNumber *remainingEstimateSeconds = objectFromDicForkey(source, kRemainingEstimateSeconds);
            NSNumber *timeSpentSeconds = objectFromDicForkey(source, kTimeSpentSeconds);
            NSInteger originalEstimateMinutes = [originalEstimateSeconds integerValue] / 60;
            NSInteger remainingEstimateMinutes = [remainingEstimateSeconds integerValue] / 60;
            NSInteger timeSpentMinutes = [timeSpentSeconds integerValue] / 60;
            timeTracking = [[MNSTimeTracking alloc] initWithOriginalEstimateMinutes:originalEstimateMinutes remainingEstimateMinutes:remainingEstimateMinutes timeSpentMinutes:timeSpentMinutes];
			timeTracking.originalEstimate = objectFromDicForkey(source, kOriginalEstimate);
			timeTracking.remainingEstimate = objectFromDicForkey(source, kRemainingEstimate);
			timeTracking.timeSpent = objectFromDicForkey(source, kTimeSpent);
        }else {
            *error = [NSError errorWithDomain:@"TimeTrackingBuilder error" code:0 userInfo:nil];

        }
    }
    @catch (NSException *exception) {
    *error = [NSError errorWithDomain:@"TimeTrackingBuilder error:Exception" code:0 userInfo:nil];
    }
    
    return timeTracking;

}

@end
