//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MPXEverydayTrip.h"

@interface MPXEverydayTrip()

@property(nonatomic, strong, readwrite) NSNumber *tripId;
@property(nonatomic, copy, readwrite) NSString *departingLocationName;
@property(nonatomic, strong, readwrite) CLLocation *departingLocation;

@property (nonatomic, copy, readwrite) NSArray *departingTimes;

@property(nonatomic, copy, readwrite) NSString *arrivingLocationName;
@property(nonatomic, strong, readwrite) CLLocation *arrivingLocation;

@end

@implementation MPXEverydayTrip

- (instancetype)initWithTripId:(NSNumber *)tripId departingLocationName:(NSString *)departingLocationName departingLocation:(CLLocation *)departingLocation departingTimes:(NSArray *)departingTimes arrivingLocationName:(NSString *)arrivingLocationName arrivingLocation:(CLLocation *)arrivingLocation {
    self = [super init];
    if (self) {
        self.tripId = tripId;
        self.departingLocationName = departingLocationName;
        self.departingLocation = departingLocation;
        self.departingTimes = departingTimes;
        self.arrivingLocationName = arrivingLocationName;
        self.arrivingLocation = arrivingLocation;
    }

    return self;
}

+ (instancetype)tripWithTripId:(NSNumber *)tripId departingLocationName:(NSString *)departingLocationName departingLocation:(CLLocation *)departingLocation departingTimes:(NSArray *)departingTimes arrivingLocationName:(NSString *)arrivingLocationName arrivingLocation:(CLLocation *)arrivingLocation {
    return [[self alloc] initWithTripId:tripId departingLocationName:departingLocationName departingLocation:departingLocation departingTimes:departingTimes arrivingLocationName:arrivingLocationName arrivingLocation:arrivingLocation];
}

@end