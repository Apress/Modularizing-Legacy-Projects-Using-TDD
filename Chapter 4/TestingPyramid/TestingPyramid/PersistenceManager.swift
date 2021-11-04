//
//  PersistenceManager.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import Foundation

class PersistenceManager {
    
    // MARK:- Singleton
    
    static let shared = PersistenceManager()
    
    // MARK:- Variables
    
    private(set) var successfulLoginsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Constants.kSuccessfulLoginsCountUserDefaultsKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.kSuccessfulLoginsCountUserDefaultsKey)
        }
    }
    
    private(set) var failedLoginsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Constants.kFailedLoginsCountUserDefaultsKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.kFailedLoginsCountUserDefaultsKey)
        }
    }
    
    // MARK:- Public Functions
    
    func incrementLogin(successful: Bool) {
        if successful {
            successfulLoginsCount += 1
        }
        else {
            failedLoginsCount += 1
        }
    }
    
    func clear() {
        self.failedLoginsCount = 0
        self.successfulLoginsCount = 0
    }
}
