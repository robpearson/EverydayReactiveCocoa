//
//  MPXViewController.m
//  EverydayReactiveCocoa
//
//  Created by Rob Pearson on 30/03/2014.
//  Copyright (c) 2014 Rob Pearson. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "MPXViewController.h"
#import "MPXViewModel.h"

@interface MPXViewController ()

@property(nonatomic, strong) MPXViewModel *viewModel;

@end

@implementation MPXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [[MPXViewModel alloc] init];

    [self bindSignals];

}

- (void)bindSignals {

    RAC(self, nextTransitTripDetail.text) = RACObserve(self, viewModel.nextTripString);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
