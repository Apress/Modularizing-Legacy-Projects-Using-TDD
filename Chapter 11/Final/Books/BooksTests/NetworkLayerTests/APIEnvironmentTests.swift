//
//  APIEnvironmentTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import XCTest
@testable import Books

class APIEnvironmentTests: XCTestCase {

    func testProductionEnvironment() {
        // When
        let env = APIEnvironment.production
        
        // Then
        XCTAssertEqual(env.host, "api.nytimes.com")
        XCTAssertEqual(env.scheme, "https")
        XCTAssertNil(env.port)
    }
    
    func testTestingEnvironment() {
        // When
        let env = APIEnvironment.testing
        
        // Then
        XCTAssertEqual(env.host, "localhost")
        XCTAssertEqual(env.scheme, "http")
        XCTAssertEqual(env.port, 8080)
    }

}
