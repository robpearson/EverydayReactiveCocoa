# ReactiveCocoa Lessons Learned

## Rob Pearson @robpearson

---

# Maple Pixel

## Everyday Transit 1.0
## coming soon ...

![fit](Maple Pixel Logo Mark.png)
![fit](EverydayTransit.jpg)

---

# FrieNDA

^ Unreleased App.  Code Examples.  Please be kind ...

---

# Everyday ReactiveCocoa

1. __*Functional Programming*__ Briefly
1. __*Signals and Pipelines*__
3. __*RAC*__ Lessons Learned

---

> Functional Programming Briefly

---

![fit](FuncNoState.png)

---

![fit](FuncTitles.png)

^ Purity: f(x) = x + 1
^ Output is calculated soley on its inputs
^ Repeatable
^ No Side Effects
^ Immutable Data

^ Higher Order Functions: Input or Output is a Function
^ map, reduce, filter, concat, take ...

---

> Signals and Pipelines

---

![fit](TransitDashboardPipelines.png)

---

# Transit Dashboard Pipeline

Inputs:
* List of Everyday Trips (Favourites)
* GPS Location
* Time

Outputs:
* Next Transit Trip

^ It's all about Inputs and Outputs

---

# Pipelines ==
# RACSignals

---

# RACSignal Example

```objectivec

[RACSignal createSignal:^(id<RACSubscriber subscriber) {

  // Do Something
	u_int32_t r = arc4random();

	// Start (and in this case complete) the signal.
	[subscriber sendNext:@(r)];
	[subscriber sendCompleted];

	return (RACDisposable *)nil;
}];

```

---

# So we have Pipelines/Signals.  Now what?

---

# Code Example: Subscribing, Error Handling etc.

---

# *RAC* Lessons Learned

---

![fit](RacLessonsLearned.png)

---

# KVO

^ This is worth the dependency

---

# No, Seriously ...  KVO!

^ This is worth the dependency

---

# Key Value Observing

```objectivec

// Bind Transit Trips to Table View
[RACObserve(self.viewModel, everydayTransitTrips) subscribeNext:^(id x) {
    @strongify(self);

    [self.tableView reloadData];

}];

```

---

# Work with Protocols

---

# rac_signalForSelector

```objectivec

[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)] subscribeNext:^(RACTuple *value) {
    @strongify(self);

    UISearchBar *searchBar = value.first;

    if (searchBar == self.departingLocationsSearchBar) {
        [self.viewModel filterDepartingLocationsByName:self.departingLocationsSearchBar.text];
    }
    else {
        [self.viewModel filterArrivingLocationsByName:self.arrivingLocationsSearchBar.text];
    }

}];

```

---

# Take advantage of RAC Category Methods

^ Touch Events, Notifications, Reachability etc.

---

# NotificationCentre

```objectivec

RACSignal *appActiveSignal = [[[[NSNotificationCenter.defaultCenter
        rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] mapReplace:@YES]
        startWith:@YES]
        setNameWithFormat:@"%@ appActive", self];

```

---

# Signal Tips and Tricks

---

# Reactive Timer #1

## Map Time

---

# Reactive Timer #1

```objectivec

    [[[[[RACSignal interval:60 onScheduler:[RACScheduler scheduler]]
            map:^id(NSDate *timestamp) {
                @strongify(self);

                  if (self.hasEverydayTrips != nil && [@(YES) isEqualToNumber:self.hasEverydayTrips]) {
                      return @"SEQ";
                  }
                  else {
                      return @"Everyday Transit";
                  }
            }]
            startWith:@"Everyday Transit"]
            distinctUntilChanged]
            deliverOn:[RACScheduler mainThreadScheduler]];

```

---

# Reactive Timer #2

## Empty Signal with a delay.

---

    RACSignal *nextTransitTripIntervalSignal = [RACSignal interval:1 onScheduler:[RACScheduler scheduler]];
    RACSignal *currentUserLocationRefreshDelay = [[RACSignal empty] delay:60];
    RACSignal *currentUserLocationRefreshSignal = [[[self.locationService.locationSignal
            take:1]
            concat:currentUserLocationRefreshDelay]
            repeat];

---

# Real Power is combing and chaining signals

---

# Protips

* Start by reading IntroToRx.com
* Start small and iterate.
* Asks questions by opening issues at http://github.com/ReactiveCocoa/

---

# Challenges

* ReactiveCocoa Doco
* Thinking like a Functional Programmer
* Debugging
* Unit Testing

---

# References

* Github Repo: http://github.com/ReactiveCocoa/
* Ray Wenderlich Tutorial: https://bit.ly/1rXA31Y
* Big Nerd Ranch Tutorial: https://bit.ly/1mp04mI
* FRP on iOS by Ash Furrow: https://leanpub.com/iosfrp
* Brent Simmons on ReactiveCocoa: https://bit.ly/PcyjCL

---

> Questions?
