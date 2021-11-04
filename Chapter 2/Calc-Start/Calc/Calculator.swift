//
//  Calculator.swift
//  Calc
//
//  Created by Hassaan El-Garem on 10/28/20.
//  Copyright © 2020 Apress. All rights reserved.
//

import Foundation

public class Calculator {
    
    // MARK:- Initializer
    
    public init() {
        self.logger = Logger()
    }
    
    // MARK:- Variables
    static let kLoggingEnabledDefaultsKey = "kLoggingEnabledDefaultsKey"
    var loggingEnabled: Bool {
        get {
            let userDefaults = UserDefaults.standard
            guard let _ = userDefaults.object(forKey: Self.kLoggingEnabledDefaultsKey) else {
                userDefaults.set(true, forKey: Self.kLoggingEnabledDefaultsKey)
                return true
            }
            return userDefaults.bool(forKey: Self.kLoggingEnabledDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.kLoggingEnabledDefaultsKey)
        }
    }
    var logger: Logger?
    
    // MARK:- Public Functions
    
    public func isLoggingEnabled() -> Bool {
        return loggingEnabled
    }
    
    public func disableLogging() {
        loggingEnabled = false
        logger = nil
    }
    
    public func enableLogging() {
        loggingEnabled = true
        logger = Logger()
    }
    
    public func add(firstArgument: Double, secondArgument: Double) -> Double {
        let output = firstArgument + secondArgument
        log(output)
        return output
    }
    
    public func subtract(firstArgument: Double, secondArgument: Double) -> Double {
        let output = firstArgument - secondArgument
        log(output)
        return output
    }
    
    public func multiply(firstArgument: Double, secondArgument: Double) -> Double {
        let output = firstArgument * secondArgument
        log(output)
        return output
    }
    
    public func divide(firstArgument: Double, secondArgument: Double) -> Double {
        let output = firstArgument / secondArgument
        log(output)
        return output
    }
    
    public func addRandomNumber(argument: Double) -> Double {
        let random: Double = randomNumber()
        let output = argument + random
        log(output)
        return output
    }
    
    public func subtractRandomNumber(argument: Double) -> Double {
        let random: Double = 5
        let output = argument - random
        log(output)
        return output
    }
    
    // MARK:- Private Helpers
    
    private func log(_ number: Double) {
        guard loggingEnabled else {
            return
        }
        try? self.logger?.log(number, completion: nil)
    }
    
    private func randomNumber() -> Double {
        return Double(Int.random(in: 1...10))
    }
}
