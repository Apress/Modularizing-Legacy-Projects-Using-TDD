//
//  LoggerTests.swift
//  CalcTests
//
//  Created by Hassaan El-Garem on 10/28/20.
//  Copyright © 2020 Apress. All rights reserved.
//

import XCTest
@testable import Calc

class LoggerTests: XCTestCase {

    func testAddLogShouldThrowIfExceedsLimit() {
        // Given
        let logger = Logger()
        let number: Double = 2000
        
        // Then
        XCTAssertThrowsError(try logger.log(number))
    }
    
    func testAddLogShouldNotThrowIfUnderLimit() {
        // Given
        let logger = Logger()
        let number: Double = 500
        
        // Then
        XCTAssertNoThrow(try logger.log(number))
    }
    
    func testAddingLog() throws {
        let exp = expectation(description: "Log added")
        // Given
        let logger = Logger()
        let number: Double = 1
        
        // When
        try logger.log(number) {
            // Then
            XCTAssertEqual(logger.logs.count, 1)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

}
