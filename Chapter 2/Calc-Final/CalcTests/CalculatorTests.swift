//
//  CalculatorTests.swift
//  CalcTests
//
//  Created by Hassaan El-Garem on 10/28/20.
//  Copyright © 2020 Apress. All rights reserved.
//

import XCTest
@testable import Calc

class CalculatorTests: XCTestCase {
        
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: Calculator.kLoggingEnabledDefaultsKey)
    }
    
    func testIsLoggingEnabledByDefault() {
        // Given
        let calc = Calculator()
        
        // When
        let isEnabled = calc.isLoggingEnabled()
        
        // Then
        XCTAssertTrue(isEnabled)
    }
    
    func testDisableLogging() {
        // Given
        let calc = Calculator()
        
        // When
        calc.disableLogging()
        let isEnabled = calc.isLoggingEnabled()
        
        // Then
        XCTAssert(!isEnabled)
    }
    
    func testAdd() {
        // Given
        let calc = Calculator()
        
        // When
        let output = calc.add(firstArgument: 1, secondArgument: 2)
        
        // Then
        XCTAssertEqual(output, 3)
    }
    
    func testLoggerIsInitializedByDefault() {
        // Given
        let calc = Calculator()
        
        // Then
        XCTAssertNotNil(calc.logger)
    }
    
    func testDisableLoggingResetsLogger() {
        // Given
        let calc = Calculator()
        
        // When
        calc.disableLogging()
        
        // Then
        XCTAssertNil(calc.logger)
    }
    
    func testAddRandomNumber() {
        // Given
        let calc = Calculator()
        
        // When
        let output = calc.addRandomNumber(argument: 1)
        
        // Then
        XCTAssertGreaterThan(output, 1)
    }
}
