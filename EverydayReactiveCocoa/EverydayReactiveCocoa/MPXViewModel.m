//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "DateTools.h"
#import "DDLog.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"
#import "MPXViewModel.h"
#import "MPXLocationService.h"
#import "MPXSettingsService.h"
#import "DDLogMacros.h"
#import "MPXEverydayTrip.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface MPXViewModel ()

// Services
@property(nonatomic, strong, readwrite) MPXSettingsService *settingsService;
@property(nonatomic, strong, readwrite) MPXLocationService *locationService;

// Helpers/Utils
@property(nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;

@end

@implementation MPXViewModel

- (instancetype)init {

    MPXSettingsService *settingsService = [MPXSettingsService new];
    MPXLocationService *locationService = [MPXLocationService sharedInstance];

    MPXViewModel *viewModel = [self initWithLocationService:locationService
                                            settingsService:settingsService];
    return viewModel;

}

- (instancetype)initWithLocationService:(MPXLocationService *)locationService
                        settingsService:(MPXSettingsService *)settingsService {

    self = [super init];
    if (self) {

        DDLogDebug(@"MPXViewModel init");

        self.settingsService = settingsService;
        self.locationService = locationService;

        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setLocale:[NSLocale currentLocale]];

        [self bindSignals];
    }

    return self;

}

- (void)bindSignals {

    DDLogDebug(@"MPXViewModel binding signals");

    RACSignal *refreshSignal = [[RACSignal interval:15 onScheduler:[RACScheduler scheduler]] startWith:[NSDate date]];
    RACSignal *everydayTripsSignal = [self.settingsService.everydayTripsSignal collect];

    // Combine Latest
    RACSignal *nextTripSignal = [[[[[[RACSignal
            combineLatest:
                    @[
                            everydayTripsSignal,
                            self.locationService.locationSignal,
                            refreshSignal
                    ]]
            reduceEach:^id(NSArray *everydayTrips, CLLocation *currentUserLocation, NSDate *timestamp) {

                return [[everydayTrips.rac_sequence map:^id(MPXEverydayTrip *everydayTrip) {

                    CLLocationDistance tmpDistance = [everydayTrip.departingLocation distanceFromLocation:currentUserLocation];
                    DDLogDebug(@"Mapping Everyday Trip w/ Departing Stop:%@ Arriving Stop:%@ Departing Stop Distance:%f", everydayTrip.departingLocationName, everydayTrip.arrivingLocationName, tmpDistance);
                    RACTuple *tuple = [RACTuple tupleWithObjects:@(tmpDistance), timestamp, everydayTrip, nil];
                    return tuple;

                }] array];

            }]
            map:^id(NSArray *unsortedEverydayTrips) {

                DDLogDebug(@"Mapping unsorted trips");

                NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"first" ascending:YES];
                NSArray *prioritisedTrips = [unsortedEverydayTrips sortedArrayUsingDescriptors:@[sortDescriptor]];

                [prioritisedTrips enumerateObjectsUsingBlock:^(RACTuple *tripDistanceTimestampAndTripDetail, NSUInteger idx, BOOL *stop) {
                    NSNumber *tmpDistance = tripDistanceTimestampAndTripDetail.first;
                    MPXEverydayTrip *everydayTrip = tripDistanceTimestampAndTripDetail.third;
                    DDLogDebug(@"Prioritised Trip w/ Departing Stop:%@ Arriving Stop:%@ Departing Stop Distance:%f", everydayTrip.departingLocationName, everydayTrip.arrivingLocationName, [tmpDistance doubleValue]);
                }];

                return prioritisedTrips;

            }]
            flattenMap:^RACStream *(NSArray *prioritisedEverydayTrips) {

                DDLogDebug(@"Mapping and flattening to get the next trip");

                NSArray *topPriorityEverydayTrip = [[NSArray alloc] init];
                if (prioritisedEverydayTrips.count > 0) {
                    RACTuple *nextTripDistanceTimestampAndTripDetail = prioritisedEverydayTrips.firstObject;
                    NSNumber *tmpDistance = nextTripDistanceTimestampAndTripDetail.first;
                    MPXEverydayTrip *everydayTrip = nextTripDistanceTimestampAndTripDetail.third;
                    topPriorityEverydayTrip = @[nextTripDistanceTimestampAndTripDetail];
                    DDLogDebug(@"Next Trip w/ Departing Stop:%@ Arriving Stop:%@ Departing Stop Distance:%f", everydayTrip.departingLocationName, everydayTrip.arrivingLocationName, [tmpDistance doubleValue]);
                }

                // Dave: Any advice on how to do this better.

                RACSequence *tmpSequence = [topPriorityEverydayTrip rac_sequence];
                RACSignal *prioritisedEverydayTripsSignal = [tmpSequence signalWithScheduler:[RACScheduler scheduler]];
                return prioritisedEverydayTripsSignal;

            }]
            map:^id(RACTuple *nextTripTimestampAndTripDetail) {

                DDLogDebug(@"Mapping next trip to next trip string");

                NSDate *timestamp = nextTripTimestampAndTripDetail.second;
                MPXEverydayTrip *everydayTrip = nextTripTimestampAndTripDetail.third;

                NSDate *nextTripDateTime = [[everydayTrip.departingTimes.rac_sequence filter:^BOOL(NSDate *departingTime) {

                    return timestamp <= departingTime;

                }] foldLeftWithStart:[NSDate distantFuture] reduce:^id(NSDate *accumulator, NSDate *newDate) {

                    NSDate *minDate = accumulator;

                    if ([newDate isEarlierThan:minDate]) {
                        minDate = newDate;
                    }

                    return minDate;

                }];

                // And then Subtract
                double minutes = [timestamp minutesEarlierThan:nextTripDateTime];

                NSString *nextTripString = [NSString stringWithFormat:@"%d minutes @ %@", (int) minutes, everydayTrip.departingLocationName];

                DDLogInfo(nextTripString);

                return nextTripString;
            }]
            deliverOn:RACScheduler.mainThreadScheduler];

    RAC(self, nextTripString) = nextTripSignal;

}

@end