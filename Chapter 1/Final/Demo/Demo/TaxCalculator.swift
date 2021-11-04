//
//  TaxCalculator.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 06/08/2021.
//

import Foundation

enum TaxCalculatorError: Error {
    case negativeSalaryError
    case zeroSalaryError
}

class TaxCalculator: NSObject {
    public func calculate(salary: Double) throws -> Double {
        try handleErrors(salary: salary)
        return salary - (salary * 0.3);
    }
    
    private func handleErrors(salary: Double) throws {
        if salary < 0  {
            throw TaxCalculatorError.negativeSalaryError
        }
        
        if salary == 0  {
            throw TaxCalculatorError.zeroSalaryError
        }
    }
}
