//
//  RuleDetailsController.swift
//  ReviewKit_Example
//
//  Created by Ajith R Nayak on 2019-02-18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ReviewKit

class RuleDetailsController: UIViewController {
    
    @IBOutlet weak var firstInputField: UITextField!
    @IBOutlet weak var secondInputField: UITextField!
    @IBOutlet weak var thirdInputField: UITextField!
    @IBOutlet weak var currentCountLabel: UILabel!
    
    var rule: Rule? = nil
    var requestInterval: RequestInterval?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstInputField.tag     = 1
        secondInputField.tag    = 2
        thirdInputField.tag     = 3
        
        configureDetails()
        self.title = rule?.title
        configureCurrentValue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let ruleInfo = rule?.ruleInfo {
            ReviewManager.default.requestReview(for: ruleInfo)
        }
    }
    
    func configureDetails() {
        guard let rule = rule else {
            return
        }
        
        self.requestInterval    = rule.ruleInfo.requestInterval
        
        firstInputField.text    = "\(requestInterval!.first)"
        secondInputField.text   = "\(requestInterval!.second)"
        thirdInputField.text    = "\(requestInterval!.repeatEvery)"
    }
    
    func configureCurrentValue() {
        guard let rule = rule else {
            return
        }
        let currentValue = UserDefaults.standard.value(forKey: rule.ruleInfo.ruleType.key) as? Int ?? 1
        self.currentCountLabel.text = "\(currentValue)"
    }
    
    @IBAction func incrementOccurrenceAction(_ sender: UIButton) {
        if let ruleType = rule?.ruleInfo.ruleType {
            ReviewManager.default.incrementOccurrence(for: ruleType)
            configureCurrentValue()
        }
        
        requestReview()
    }
    
    @IBAction func inputFieldDidChangeText(_ sender: UITextField) {
        
        guard let input = sender.text, !input.isEmpty,
            let intValue = Int(input),
            let currentInterval = self.requestInterval else {
                return
        }
        
        switch sender.tag {
        case 1:
            self.requestInterval = RequestInterval(first: intValue,
                                                   second: currentInterval.second,
                                                   repeatEvery: currentInterval.repeatEvery)
        case 2:
            self.requestInterval = RequestInterval(first: currentInterval.first,
                                                   second: intValue,
                                                   repeatEvery: currentInterval.repeatEvery)
        case 3:
            self.requestInterval = RequestInterval(first: currentInterval.first,
                                                   second: currentInterval.second,
                                                   repeatEvery: intValue)
        default:
            break
        }
        
        requestReview()
    }
    
    func requestReview() {
        guard let rule = rule, let currentInterval = self.requestInterval  else {
            return
        }
        
        let reviewRule = RequestReviewRule(ruleType: rule.ruleInfo.ruleType, requestInterval: currentInterval)
        ReviewManager.default.requestReview(for: reviewRule)
    }
    
}
