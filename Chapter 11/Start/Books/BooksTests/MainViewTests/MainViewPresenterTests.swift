//
//  MainViewPresenterTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 02/06/2021.
//

import XCTest
@testable import Books

class MainViewPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingBestSellerBooksReturnsLists() throws {
        // Given
        let expectedLists: [List] = stubbedlists()
        var actualLists: [List] = []

        let mainViewModel = MainViewModelStub(stubbedLists: expectedLists)
        
        // when & then
        let waitForBooks = XCTestExpectation(description: "Wait to fetch books")
        mainViewModel.fetchBestSellerBooks { lists in
            actualLists = lists ?? []
            waitForBooks.fulfill()
        }
        
        self.wait(for: [waitForBooks], timeout: 0.1)
        XCTAssertEqual(actualLists, expectedLists, "Fetched books does not match the expected")
    }
    
    func stubbedlists() -> [List] {
        let buyLink1 = BuyLinkModel(name: .amazon, url: "URL")
        var firstBook = BookModel(title: "THE LAST THING HE TOLD ME", contributor: "by Laura Dave", author: "Laura Dave", createdDate: "2021-05-26 22:10:24")
        firstBook.amazonProductURL = "https://www.amazon.com/dp/1501171348?tag=NYTBSREV-20"
        firstBook.bookImage = "https://storage.googleapis.com/du-prd/books/images/9781501171345.jpg"
        firstBook.bookDescription = "Hannah Hall discovers truths about her missing husband and bonds with his daughter from a previous relationship."
        firstBook.publisher = "Simon & Schuster"
        firstBook.buyLinks = [buyLink1]

        let buyLink2 = BuyLinkModel(name: .amazon, url: "URL")
        var secondBook = BookModel(title: "SOOLEY", contributor: "by John Grisham", author: "John Grisham", createdDate: "2021-05-26 22:10:24")
        secondBook.amazonProductURL = "https://www.amazon.com/dp/0385547684?tag=NYTBSREV-20"
        secondBook.bookImage = "https://storage.googleapis.com/du-prd/books/images/9780385547680.jpg"
        secondBook.bookDescription = "Samuel Sooleymon receives a basketball scholarship to North Carolina Central and determines to bring his family over from a civil war-ravaged South Sudan."
        secondBook.publisher = "Doubleday"
        secondBook.buyLinks = [buyLink2]
        
        let firstList = List(listID: 704, listName: "Combined Print and E-Book Fiction", displayName: "Combined Print & E-Book Fiction", books: [firstBook,secondBook])
        return [firstList]
    }

}
