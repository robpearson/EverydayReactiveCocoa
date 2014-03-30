# Everyday ReactiveCocoa

## Rob Pearson @robpearson

---

# Maple Pixel.  

## Everyday Transit coming soon.

^ Add Image

---

# Thoughts and Experience using ReactiveCocoa Everyday for 5-6 months

^ Everyday since November

---

> FrieNDA.   

^ Unreleased App.  Code Examples.  Please be kind ... 

---

# Everyday ReactiveCocoa

1. Review __*Functional*__ Programming 
2. Introduce Functional __*Reactive*__ Programming
3. Everyday __*ReactiveCocoa*__ Code Examples

---

> Review Functional Programming

---

# Functional Programming

## In functional programming, programs are executed by evaluating expressions  ... avoids using mutable state.

##### - Haskell Wiki http://haskell.org/haskellwiki/Functional_programming

^ Declarative, Expressive, Side Effect Free.  This eliminates a whole class of bugs inherently.  

--- 

# Functional Building Blocks

* Purity
* Higher Order Functions
* Recursion 

--- 

# Purity

## f(x) = x + 1

^ Output is calculated soley on its inputs
^ Repeatable
^ No Side Effects
^ Immutable Data

---

# Higher Order Functions

## Input or Output is a Function

^ map, reduce, filter, concat, take ...

---

# Recursion

## Haskell Wiki included this so I did too.

---

> Functional Reactive Programming

---

# Inputs and Ouputs - Josh Abernathy

# "Programs take input and produce output. The output is the result of doing something with the input. Input, transform, output, done."

### "The output at any one time is the result of combining all inputs. The output is a function of all inputs up to that time." - Josh Abernathy

-- http://blog.maybeapps.com/post/42894317939/input-and-output

---

# Inputs

* Keyboard (text) input
* Click/Touches (mouse, finger) input
* Timers (intervals)
* Location changes
* Data from webservices
* Images from webservices

---

# Outputs

* Display
* Sounds
* Persist data somewhere
* Push data to the cloud

---

# Standard Programming vs. Reactive Programming

## Event Handlers, Delegates, KVO etc. vs. Descriptive Expressions to Handle Events

---

# Why is FRP better?  

* Minimal App State
* Declarative
* Expressive
* Different ... 

--- 

# Expressiveness

Typical example, a sign-up form:

```objectivec
RAC(self.submitButton, enabled) = [RACSignal
    combineLatest:@[
        self.firstNameField.rac_textSignal,
        self.lastNameField.rac_textSignal,
        self.emailField.rac_textSignal,
        self.reEmailField.rac_textSignal
    ]
    reduce:^(NSString *first, NSString *last, NSString *email, NSString *reEmail) {
        return @(first.length > 0 && last.length > 0 && email.length > 0 && reEmail.length > 0 && [email isEqual:reEmail]);
    }];
```

##### https://github.com/kastiglione/ExpressiveReactiveCocoa

---

> Boom!

---

> Everyday __*ReactiveCocoa*__ Code Examples

---

# ReactiveCocoa

## Reactive Functional Programming framework by Github

---

# RACSignal is the king!

---

# RAC for KVO (RACObserver) produces a signal

---

# RAC macro for binding a signal to a property

---

# RAC for handling selectors etc

---

# RAC helpers for generating signals from controls

---

# Real Power is combing and chaining signals

# Build the Pipeline

---

### Transit Dashboard.
Inputs
* Transit Time table for the day
* Location Updates
* Time Updates

Output
* Next Transit Service based on time/location
* Future Transit Services based on time/location

---

# ReactiveCocoa v3 is coming soon

---

# Protips

* Start by reading IntroToRx.com
* Asks questions by opening issues at http://github.com/ReactiveCocoa/
* 

---

> Questions?

---

# References

* http://haskell.org/haskellwiki/Functional_programming
* Intro to RX : http://IntroToRx.com

---

# Reactive Cocoa References

* FRP on iOS by Ash Furrow : https://leanpub.com/iosfrp
* NSHipster on RAC : http://nshipster.com/reactivecocoa/
* Ray Wenderlich on RAC
* Big Nerd Ranch on RAC 

---
