//
//  BookViewModelTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import XCTest
@testable import Books

class BookViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingBookReveiws() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let booksReveiwsJSONURL = testBundle.url(forResource: "booksReview", withExtension: "json")
        let booksReveiwsJSON = try Data(contentsOf: booksReveiwsJSONURL!)
        let networkLayer = NetworkLayerStub(stubbedData: booksReveiwsJSON)
        
        let expectedReviews: [Review] = stubbedReviews()
        var actualReviews: [Review]?

        
        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: nil)
        
        // when & then
        let waitForBookReviews = XCTestExpectation(description: "Wait to fetch book reveiws")
        bookViewModel.fetchBookReviews(with: "Title", callBack: { reviews in
            actualReviews = reviews
            waitForBookReviews.fulfill()
        })
        
        self.wait(for: [waitForBookReviews], timeout: 0.1)
        XCTAssertEqual(actualReviews, expectedReviews, "Fetched books does not match the expected")
    }
    
    func stubbedReviews() -> [Review]{
        return [Review(byLine:"ERROL MORRIS", summary:"The book is interesting")]
    }
}
