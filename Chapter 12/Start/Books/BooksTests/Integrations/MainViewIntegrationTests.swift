//
//  MainViewIntegrationTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 02/06/2021.
//

import XCTest
@testable import Books

class MainViewIntegrationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchBestSellerBooksReturnsLists() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let booksJSONURL = testBundle.url(forResource: "BestSellerBooksStub", withExtension: "json")
        let booksJSON = try Data(contentsOf: booksJSONURL!)

        let expectedLists: [List] = stubbedlists()
        var actualLists: [List] = []

        let networkLayer = NetworkLayerStub(stubbedData: booksJSON)
        let mainViewModel = MainViewModel(network: networkLayer)
        let mainViewPresenter = MainViewPresenter(mainViewModel: mainViewModel)

        // when & then
        let waitForBooks = XCTestExpectation(description: "Wait to fetch books")
        mainViewPresenter.fetchBestSellerBooks { lists in
            actualLists = lists ?? []
            waitForBooks.fulfill()
        }
        
        self.wait(for: [waitForBooks], timeout: 0.1)
        XCTAssertEqual(actualLists, expectedLists, "Fetched books does not match the expected")
    }
    
    func stubbedlists() -> [List] {
        let firstBook = BookModel(title: "THE LAST THING HE TOLD ME", contributor: "by Laura Dave", author: "Laura Dave", createdDate: "2021-05-26 22:10:24")
        let secondBook = BookModel(title: "SOOLEY", contributor: "by John Grisham", author: "John Grisham", createdDate: "2021-05-26 22:10:24")

        let firstList = List(listID: 704, listName: "Combined Print and E-Book Fiction", displayName: "Combined Print & E-Book Fiction", books: [firstBook,secondBook])
        return [firstList]
    }
}
