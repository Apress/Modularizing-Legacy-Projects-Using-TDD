//
//  StatisticsViewController.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    // MARK:- Strings
    
    private static let successfulCountString = "Number of successful logins is "
    private static let failedCountString = "Number of failed logins is "
    
    // MARK:- Outlets

    @IBOutlet weak var statisticsLabel: UILabel!
    @IBOutlet weak var successfulCountLabel: UILabel!
    @IBOutlet weak var failedCountLabel: UILabel!
    
    // MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        setCountLabels()
    }
    
    private func setCountLabels() {
        successfulCountLabel.text = Self.successfulCountString + "\(PersistenceManager.shared.successfulLoginsCount)"
        failedCountLabel.text = Self.failedCountString + "\(PersistenceManager.shared.failedLoginsCount)"
    }
    
    private func setupAccessibilityIdentifiers() {
        statisticsLabel.accessibilityIdentifier = AccessibilityIdentifiers.kStatisticsTitleLabelIdentifier
        successfulCountLabel.accessibilityIdentifier = AccessibilityIdentifiers.kSuccessfulCountLabelIdentifier
        failedCountLabel.accessibilityIdentifier = AccessibilityIdentifiers.kFailedCountLabelIdentifier
    }

}
