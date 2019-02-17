//
//  ReviewManager.swift
//  ReviewKit
//
//  Created by Ajith R Nayak on 2019-01-20.
//

import Foundation
import StoreKit

/// To adhere to best practices, the intervals for prompting rating request are divided into three type.
public struct RequestInterval {
    public let first: Int
    public let second: Int
    public let repeatEvery: Int
    
    // MARK: Initializers

    /// Use to initialize RequestInterval
    ///
    /// - Parameters:
    ///   - first: The first time the ratings request prompt needs to be shown
    ///   - second: The second time the ratings request prompt needs to be shown
    ///   - repeatEvery: The interval that needs to be repeated for requesting for ratings.
    public init(first: Int, second: Int, repeatEvery: Int) {
        self.first          = first
        self.second         = second
        self.repeatEvery    = repeatEvery
    }
}

/// The different rules to determine
/// Note - Never ask for a rating on first launch or during onboarding. Allow ample time to form an opinion.
///
/// - appLaunches: This rule determines engagment with the app based on number of App launches
/// - customProcess: This is custom engagement process made unique using it's `Key`
public enum RequestReviewRuleType {
    case appLaunches
    case customProcess(key: String)
    
    
    /// Key used to uniquely identify each rule.
    public var key: String {
        switch self {
        case .appLaunches:
            return "RK_APP_LAUNCH_COUNT"
            
        case .customProcess(let key):
            return key
        }
    }
}

/// A Rule consists of it's type information and different request intervals to prompt ratings.
public struct RequestReviewRule {
    public let ruleType: RequestReviewRuleType
    public let requestInterval: RequestInterval
    
    // MARK: Initializers
    
    /// Use to initialize app engagment rules using `RequestReviewRule`
    ///
    /// - Parameters:
    ///   - ruleType: A `RequestReviewRuleType` case
    ///   - requestInterval: The different intervals to prompt for ratings.
    public init(ruleType: RequestReviewRuleType, requestInterval: RequestInterval) {
        self.ruleType           = ruleType
        self.requestInterval    = requestInterval
    }
}

/// A helper wrapper to easily record different app engagment rules
/// and then prompt request for app ratings and reviews.
public final class ReviewManager {
    
    // MARK: Shared Accessor
    
    /// A shared instance of ReviewManager
    public static let `default` = ReviewManager()
    
    // MARK: Initializer
    
    private init() { }

    // MARK: Private
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: Increment Rule Counter
    
    /// Use to increment occurrence of an app engagment process. Defaults to `1`
    ///
    /// - Parameter ruleType: The type of app engagment rule
    public func incrementOccurrence(for ruleType: RequestReviewRuleType) {
        
        let ruleKey = ruleType.key
        
        //fetch the existing value of key
        let existingValue = userDefaults.value(forKey: ruleKey) as? Int
        //increment if exists or default to `1`
        let newValue = existingValue == nil ? 1 : existingValue!+1
        //update user defaults
        userDefaults.set(newValue, forKey: ruleKey)
    }
    
    /// Use to increment occurence of a number of app engagment rules.
    ///
    /// - Parameter ruleTypes: A collection of app engagment rule types
    public func incrementOccurence(for ruleTypes: [RequestReviewRuleType]) {
        
        for ruleType in ruleTypes {
            incrementOccurrence(for: ruleType)
        }
    }
    
    // MARK: Reset Counter
    
    /// Use to reset all the recording of app engagement based on rule type.
    ///
    /// - Parameter ruleType: The type of app engagment rule
    public func resetOccurences(for ruleType: RequestReviewRuleType) {
        userDefaults.removeObject(forKey: ruleType.key)
    }
    
    /// Use the convenience implementation to reset all the recordings of a collection of rule types.
    ///
    /// - Parameter ruleTypes: A collection of app engagment rules
    public func resetOccurrences(for ruleTypes: [RequestReviewRuleType]) {
        for ruleType in ruleTypes {
            resetOccurences(for: ruleType)
        }
    }

    // MARK: Request Review
    
    /// Use to ask for a rating and review using `SKStoreReviewController`, if appropriate.
    /// NOTE - display of a rating/review request view is governed by App Store policy
    /// https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview
    ///
    /// - Parameter rule: A request review rule to prompt.
    public func requestReview(for rule: RequestReviewRule) {
        
        let ruleType    = rule.ruleType
        let ruleKey     = ruleType.key
        //fetch the existing value of key. If nil, default to 0
        let occurenceCount: Int = userDefaults.value(forKey: ruleKey) as? Int ?? 0
        
        let requestInterval = rule.requestInterval
        
        switch occurenceCount {
        case requestInterval.first, requestInterval.second:
            requestReview()
            
        default:
            if occurenceCount % requestInterval.repeatEvery == 0 {
                requestReview()
            }
        }
    }
    
    // MARK: Helper
    
    private func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
    }
    
}
