//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import "MPXViewModel.h"
#import "MPXLocationService.h"
#import "MPXSettingsService.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"

@interface MPXViewModel()

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

//        DDLogDebug(@"MPXTransitDashboardViewModelX - Initialising View Model.");

        self.settingsService = settingsService;
        self.locationService = locationService;

        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setLocale:[NSLocale currentLocale]];

        [self bindSignals];
    }

    return self;

}

- (void)bindSignals {

    @weakify(self);

    // Combine Latest
//    [RACSignal combineLatest:@[self.locationService.locationSignal, self.settingsService.everydayTripsSignal]]


}

@end