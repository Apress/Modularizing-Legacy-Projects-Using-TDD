//
//  BooksUITests.swift
//  BooksUITests
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import XCTest
import Swifter

class BooksUITests: XCTestCase {
    var server = HttpServer()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        do {
            try server.start()
        } catch {
            XCTFail("Server failed to start")
        }
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        server.stop()
    }

    func testShowingBestSellerBooks() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let booksJSONURL = testBundle.url(forResource: "BestSellerBooksStub", withExtension: "json")
        let booksJSON = try String(contentsOf: booksJSONURL!)
        server.GET["/svc/books/v3/lists/overview.json"] = {_ in HttpResponse.ok(.text(booksJSON))}
        
        let app = XCUIApplication()
        app.launchArguments += ["TESTING"]
        app.launch()
        
        // When
        let booksTableView = app.tables
        let cells = booksTableView.cells
        _ = cells.firstMatch.waitForExistence(timeout: 1.0)
        
        // Then
        XCTAssertTrue(cells.staticTexts["book_title_0"].label == "THE LAST THING HE TOLD ME")
        XCTAssertTrue(cells.staticTexts["book_desc_0"].label == "Hannah Hall discovers truths about her missing husband and bonds with his daughter from a previous relationship.")
        XCTAssertTrue(cells.staticTexts["book_date_0"].label == "2021-05-26 22:10:24")

        
        XCTAssertTrue(cells.staticTexts["book_title_1"].label == "SOOLEY")
        XCTAssertTrue(cells.staticTexts["book_desc_1"].label == "Samuel Sooleymon receives a basketball scholarship to North Carolina Central and determines to bring his family over from a civil war-ravaged South Sudan.")
        XCTAssertTrue(cells.staticTexts["book_date_1"].label == "2021-05-26 22:10:24")
    }
}
