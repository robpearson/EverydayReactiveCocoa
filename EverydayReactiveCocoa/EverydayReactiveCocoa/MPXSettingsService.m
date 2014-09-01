//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import "NSDate+Calendar.h"
#import "ReactiveCocoa.h"
#import <CoreLocation/CoreLocation.h>
#import "MPXSettingsService.h"
#import "MPXEverydayTrip.h"

@implementation MPXSettingsService
- (RACSignal *)everydayTripsSignal {

    RACSignal *everydayTripsSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

        [subscriber sendNext:[MPXEverydayTrip tripWithTripId:@1
                                       departingLocationName:@"Central"
                                           departingLocation:[[CLLocation alloc] initWithLatitude:-27.465716 longitude:153.025903]
                                              departingTimes:
                                                      @[
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:19 minute:01 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:20 minute:02 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:21 minute:03 second:00],
                                                      ]
                                        arrivingLocationName:@"Bald Hills"
                                            arrivingLocation:[[CLLocation alloc] initWithLatitude:-27.320967 longitude:153.011308]]];

        [subscriber sendNext:[MPXEverydayTrip tripWithTripId:@2
                                       departingLocationName:@"Bald Hills"
                                           departingLocation:[[CLLocation alloc] initWithLatitude:-27.320967 longitude:153.011308]
                                              departingTimes:
                                                      @[
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:19 minute:31 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:20 minute:32 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:21 minute:33 second:00],
                                                      ]
                                        arrivingLocationName:@"Central"
                                            arrivingLocation:[[CLLocation alloc] initWithLatitude:-27.465716 longitude:153.025903]]];

        [subscriber sendNext:[MPXEverydayTrip tripWithTripId:@3
                                       departingLocationName:@"Fortitude Valley"
                                           departingLocation:[[CLLocation alloc] initWithLatitude:-27.456087 longitude:153.033669]
                                              departingTimes:
                                                      @[
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:19 minute:11 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:20 minute:12 second:00],
                                                              [NSDate dateWithYear:2014 month:9 day:2 hour:21 minute:13 second:00],
                                                      ]
                                        arrivingLocationName:@"Bald Hills"
                                            arrivingLocation:[[CLLocation alloc] initWithLatitude:-27.320967 longitude:153.011308]]];


        [subscriber sendCompleted];

        return nil;
    }];

    return everydayTripsSignal;
}
@end