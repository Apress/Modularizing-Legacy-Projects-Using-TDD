//
//  Logger.swift
//  Calc
//
//  Created by Hassaan El-Garem on 10/28/20.
//  Copyright © 2020 Apress. All rights reserved.
//

import Foundation

enum LoggerError: Error {
    case numberGreaterThanLimit
}

class Logger {
    
    // MARK:- Type Alias
    
    typealias LogCompletion = () -> Void
    
    // MARK:- Variables
    
    static let numberUpperLimit: Double = 1000
    let queue = DispatchQueue(label: "Apress.Calc.LoggerQueue")
    var logs: [Double] = []
    
    // MARK:- Public Functions
    
    public func log(_ number: Double, completion: LogCompletion? = nil) throws {
        print(number)
        guard number < Self.numberUpperLimit else {
            throw LoggerError.numberGreaterThanLimit
        }
        queue.async {
            self.logs.append(number)
            completion?()
        }
    }
    
}
