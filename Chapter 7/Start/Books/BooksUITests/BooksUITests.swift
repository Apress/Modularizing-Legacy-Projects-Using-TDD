//
//  BooksUITests.swift
//  BooksUITests
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import XCTest

class BooksUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowingBestSellerBooks() throws {
        // Given
        let app = XCUIApplication()
        app.launch()
        
        // When
        let booksTableView = app.tables
        let cells = booksTableView.cells
        _ = cells.firstMatch.waitForExistence(timeout: 1.0)
        
        // Then
        XCTAssertGreaterThan(cells.count, 0)
    }
}
