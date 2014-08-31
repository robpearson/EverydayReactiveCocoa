//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MPXLocationService.h"
#import "ReactiveCocoa.h"

@interface MPXLocationService ()

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MPXLocationService

+ (MPXLocationService *)sharedInstance {

    static MPXLocationService *sharedLocationService;
    static dispatch_once_t pred;

    dispatch_once(&pred, ^{
        sharedLocationService = [[MPXLocationService alloc] init];
    });

    return sharedLocationService;
}

- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 100; // 100 m accuracy
    }

    return self;
}

- (RACSignal *)locationSignal {

    RACSignal *locationSignal = [RACSignal
            createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

                [[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:) fromProtocol:@protocol(CLLocationManagerDelegate)] subscribeNext:^(RACTuple *value) {

                    NSArray *locations = value[1]; // Ignore the location manager
                    [subscriber sendNext:locations.lastObject];

                }];

                [[self rac_signalForSelector:@selector(locationManager:didFailWithError:) fromProtocol:@protocol(CLLocationManagerDelegate)] subscribeNext:^(RACTuple *value) {

                    NSError *error = value[1]; // Ignore the location manager
                    if (error.domain == kCLErrorDomain && error.code == kCLErrorLocationUnknown) {
                        return;
                    }
                    [subscriber sendError:error];

                }];

                [self start];

                return [RACDisposable disposableWithBlock:^{
                    [self stop];
                }];
            }
    ];

    return locationSignal;

}

- (void)start {

    [self.locationManager startUpdatingLocation];

}

- (void)stop {

    [self.locationManager stopUpdatingLocation];

}

@end