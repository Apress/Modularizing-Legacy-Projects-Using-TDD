//
//  ReviewsRequestTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import XCTest
@testable import Books

class ReviewsRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReviewsRequestHTTPMethod() {
        //Given
        let reviewsRequest = ReviewsRequest(title: "title")
        
        //When & Then
        XCTAssertEqual(reviewsRequest.method, .GET)
    }
    
    func testReviewsRequestURL() {
        //Given
        let reviewsRequest = ReviewsRequest(title: "title")
        let env = APIEnvironment(scheme: "http", host: "test.com", port: 433, API_KEY: "")
        
        // When
        let urlRequest = reviewsRequest.createURLRequest(with: env)
        
        //When & Then
        XCTAssertEqual(urlRequest?.url?.absoluteString, "http://test.com:433/svc/books/v3/reviews.json?title=title&api-key=\(APIEnvironment.production.API_KEY)")
    }
    
    func testReviewsRequestBody() {
        //Given
        let reviewsRequest = ReviewsRequest(title: "title")

        //When & Then
        XCTAssertNil(reviewsRequest.body)
    }
}
