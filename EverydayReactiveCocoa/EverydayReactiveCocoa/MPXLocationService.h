//
// Created by Rob Pearson on 29/08/2014.
// Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface MPXLocationService : NSObject<CLLocationManagerDelegate>

+ (MPXLocationService *)sharedInstance;

- (RACSignal *)locationSignal;

@end