//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface MPXEverydayTrip : NSObject

@property(nonatomic, strong, readonly) NSNumber *tripId;
@property(nonatomic, copy, readonly) NSString *departingLocationName;
@property(nonatomic, strong, readonly) CLLocation *departingLocation;

@property (nonatomic, copy, readonly) NSArray *departingTimes;

@property(nonatomic, copy, readonly) NSString *arrivingLocationName;
@property(nonatomic, strong, readonly) CLLocation *arrivingLocation;

- (instancetype)initWithTripId:(NSNumber *)tripId departingLocationName:(NSString *)departingLocationName departingLocation:(CLLocation *)departingLocation departingTimes:(NSArray *)departingTimes arrivingLocationName:(NSString *)arrivingLocationName arrivingLocation:(CLLocation *)arrivingLocation;

+ (instancetype)tripWithTripId:(NSNumber *)tripId departingLocationName:(NSString *)departingLocationName departingLocation:(CLLocation *)departingLocation departingTimes:(NSArray *)departingTimes arrivingLocationName:(NSString *)arrivingLocationName arrivingLocation:(CLLocation *)arrivingLocation;


@end