//
//  RequestProtocolTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import XCTest
@testable import Books

class RequestProtocolTests: XCTestCase {

    func testCreateURLRequest() {
        // Given
        let environment = APIEnvironment(scheme: "http", host: "test.com", port: 433, API_KEY: "KEY")
        let request = TestRequest()
        
        // When
        let urlRequest = request.createURLRequest(with: environment)
        
        // Then
        XCTAssertEqual(urlRequest?.url?.absoluteString, "http://test.com:433/api/mock?offset=20")
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.httpBody, "Request Data".data(using: .utf8))
    }

}
