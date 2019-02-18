# ReviewKit

[![CI Status](https://img.shields.io/travis/ajithrnayak@icloud.com/ReviewKit.svg?style=flat)](https://travis-ci.org/ajithrnayak@icloud.com/ReviewKit)
[![Version](https://img.shields.io/cocoapods/v/ReviewKit.svg?style=flat)](https://cocoapods.org/pods/ReviewKit)
[![License](https://img.shields.io/cocoapods/l/ReviewKit.svg?style=flat)](https://cocoapods.org/pods/ReviewKit)
[![Platform](https://img.shields.io/cocoapods/p/ReviewKit.svg?style=flat)](https://cocoapods.org/pods/ReviewKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Available on SDK iOS 10.3+

## Installation

ReviewKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReviewKit'
```

## Best Practices
1. [Human Interface Guidelines - Ratings and Reviews](https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/ratings-and-reviews/)
2. [Sample Code - Requesting App Store Reviews](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews)

3. [SKStoreReviewController](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview)

## Usage

**Define rules to show prompt:**  
```Swift
// Request to rate or/and write a review on 3rd, 20th app launches & repeat for every 100th app launch
let appLaunchInterval = RequestInterval(first: 3, second: 20, repeatEvery: 100)
let rule1 = RequestReviewRule(ruleType: .appLaunches, requestInterval: appLaunchInterval)

// Request to rate or/and write a review on 5th and 15th time user finishes Say Hello process. Request again on every 50th time.
let sayHelloProcessInterval = RequestInterval(first: 5, second: 15, repeatEvery: 50)
let rule2 = RequestReviewRule(ruleType: .customProcess(key: "SAY_HELLO"), requestInterval: sayHelloProcessInterval)

// Request to rate or/and write a review on 5th and 10th time user finishes Wave Bye process. Request again on every 20th wave bye.
let waveByeProcessInterval = RequestInterval(first: 5, second: 10, repeatEvery: 20)
let rule3 = RequestReviewRule(ruleType: .customProcess(key: "WAVE_BYE"), requestInterval: waveByeProcessInterval)
```

**Increment the occurrence of event/process:**
```Swift
func application(_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Registers and increments occurrence of app launch event
    ReviewManager.default.incrementOccurrence(for: .appLaunches)
    return true
}
```

**Request for App rating/review**
```Swift
// Asks the user for ratings and review, if appropriate. 
ReviewManager.default.requestReview(for: appLaunchRule)
```

## License

ReviewKit is available under the MIT license. See the LICENSE file for more info.
