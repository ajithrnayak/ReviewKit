//
//  ReviewManagerTests.swift
//  ReviewKit_Tests
//
//  Created by Ajith R Nayak on 2019-02-15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import ReviewKit

class ReviewManagerTests: XCTestCase {

    override func setUp() {
        
    }

    func test1_incrementOccurrenceForAppLaunchSuccessfully() {
        //given
        let reviewManager = ReviewManager.default
        let ruleType = RequestReviewRuleType.appLaunches
        reviewManager.resetOccurences(for: ruleType)
        // when
        reviewManager.incrementOccurrence(for: ruleType)
        // then
        let count = UserDefaults.standard.value(forKey: ruleType.key) as? Int
        XCTAssertNotNil(count)
        XCTAssertEqual(1, count)
    }
    
    func test2_subsequentIncrementForAppLaunchSuccessfully() {
        //given
        let reviewManager = ReviewManager.default
        let ruleType = RequestReviewRuleType.appLaunches
        reviewManager.resetOccurences(for: ruleType)
        // when
        for _ in 1...4 {
            reviewManager.incrementOccurrence(for: ruleType)
        }
        // then
        let count = UserDefaults.standard.value(forKey: ruleType.key) as? Int
        XCTAssertNotNil(count)
        XCTAssertEqual(4, count)
    }
    
    func test3_incrementOccurrenceForCustomProcessSuccessfully() {
        //given
        let reviewManager = ReviewManager.default
        let ruleType = RequestReviewRuleType.customProcess(key: "TASK_COMPLETED")
        reviewManager.resetOccurences(for: ruleType)
        // when
        for _ in 1...4 {
            reviewManager.incrementOccurrence(for: ruleType)
        }
        // then
        let count = UserDefaults.standard.value(forKey: ruleType.key) as? Int
        XCTAssertNotNil(count)
        XCTAssertEqual(4, count)
    }
    
    func test4_incrementOccurrenceForMultipleRulesSuccessfully() {
        //given
        let reviewManager = ReviewManager.default
        let ruleType1 = RequestReviewRuleType.customProcess(key: "TASK_COMPLETED")
        let ruleType2 = RequestReviewRuleType.customProcess(key: "TASK_DELETED")
        let ruleType3 = RequestReviewRuleType.appLaunches
        let ruleTypes = [ruleType1,ruleType2, ruleType3]
        reviewManager.resetOccurrences(for: ruleTypes)
        //when
        reviewManager.incrementOccurence(for: ruleTypes)
        // then
        for ruleType in ruleTypes {
            let count = UserDefaults.standard.value(forKey: ruleType.key) as? Int
            XCTAssertNotNil(count)
            XCTAssertEqual(1, count)
        }
    }

}
