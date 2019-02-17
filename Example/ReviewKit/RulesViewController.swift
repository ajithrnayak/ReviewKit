//
//  RulesViewController.swift
//  ReviewKit_Example
//
//  Created by Ajith R Nayak on 2019-02-18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ReviewKit

typealias Rule = (title: String, ruleInfo: RequestReviewRule)

class RulesViewController: UITableViewController {

    var rules = [Rule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "App Engagement Rules"
        self.tableView.tableFooterView = UIView()
        
        configureRules()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ReviewManager.default.requestReview(for: rules.first!.ruleInfo)
    }
    
    private func configureRules() {
        
        let appLaunchInterval = RequestInterval(first: 3, second: 20, repeatEvery: 100)
        let rule1 = RequestReviewRule(ruleType: .appLaunches, requestInterval: appLaunchInterval)
        self.rules.append(("App Launch", rule1))
        
        let sayHelloProcessInterval = RequestInterval(first: 5, second: 15, repeatEvery: 50)
        let rule2 = RequestReviewRule(ruleType: .customProcess(key: "SAY_HELLO"), requestInterval: sayHelloProcessInterval)
        self.rules.append(("Say Hello", rule2))
        
        let waveByeProcessInterval = RequestInterval(first: 5, second: 10, repeatEvery: 20)
        let rule3 = RequestReviewRule(ruleType: .customProcess(key: "WAVE_BYE"), requestInterval: waveByeProcessInterval)
        self.rules.append(("Wave Bye", rule3))
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = rules[indexPath.row].title
        cell.selectionStyle = .none
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "RuleDetailsController") as! RuleDetailsController
        detailsVC.rule = rules[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
