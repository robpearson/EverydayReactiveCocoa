//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPXLocationService;
@class MPXSettingsService;

@interface MPXViewModel : NSObject

- (instancetype)init;

- (instancetype)initWithLocationService:(MPXLocationService *)locationService settingsService:(MPXSettingsService *)settingsService;

@property(nonatomic, copy) NSString *nextTripString;

@end