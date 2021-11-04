//
//  DemoTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 06/08/2021.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        //  Given
        let calculator = TaxCalculator()
        
        // When
        let netSalary = try calculator.calculate(salary: 100)
        
        // Then
        XCTAssertEqual(netSalary, 70,
                       "Net salary should be 70$ when you subtract 30% taxes from 100$")
    }
    
    
    func testPassingZero() throws {
        //  Given
        let calculator = TaxCalculator()
        
        // When
        do {
            _ = try calculator.calculate(salary: 0)
        } catch let caughtError as TaxCalculatorError {
            // Then
            XCTAssertEqual(caughtError,  .zeroSalaryError, "Should throw error when passing a zero salary.")
        }
    }
    
    
    func testPassingNegativeNumber() throws {
        //  Given
        let calculator = TaxCalculator()
        
        // When
        do {
            _ = try calculator.calculate(salary: -1)
        } catch let caughtError as TaxCalculatorError {
            // Then
            XCTAssertEqual(caughtError,  .negativeSalaryError, "Should throw error when passing a negative salary.")
        }
    }
    
    func testPassingFractionNumber() throws {
        //  Given
        let calculator = TaxCalculator()
        
        // When
        let netSalary = try calculator.calculate(salary: 0.5)
        
        // Then
        XCTAssertEqual(netSalary, 0.35,
                       "Net salary should be 0.35$ when you subtract 30% taxes from 0.5$")
    }
    
}
