//
//  BookRequestTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import XCTest
@testable import Books

class BookRequestTests: XCTestCase {

    func testBookRequestHTTPMethod() {
        //Given
        let bookRequest = BooksRequest()
        
        //When & Then
        XCTAssertEqual(bookRequest.method, .GET)
    }

    func testBookRequestURL() {
        //Given
        let bookRequest = BooksRequest()
        let env = APIEnvironment(scheme: "http", host: "test.com", port: 433, API_KEY: "")
        
        // When
        let urlRequest = bookRequest.createURLRequest(with: env)
        
        //When & Then
        XCTAssertEqual(urlRequest?.url?.absoluteString, "http://test.com:433/svc/books/v3/lists/overview.json?offset=20&api-key=\(APIEnvironment.production.API_KEY)")
    }

    func testBookRequestBody() {
        //Given
        let bookRequest = BooksRequest()
        
        //When & Then
        XCTAssertNil(bookRequest.body)
    }

}
