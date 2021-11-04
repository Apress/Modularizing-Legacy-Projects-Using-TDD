//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by khaled mohamed el morabea on 10/28/20.
//

import XCTest

class DemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual(app.tables.cells.count, 6)
        
        let cell = app.tables.staticTexts["San Francisco"]        
        cell.tap()
        
        let titleLabel = app.navigationBars.staticTexts["San Francisco"]
        XCTAssertTrue(titleLabel.exists)
        
        let helloButton = app.buttons["Hello"]
        helloButton.tap()
        
        XCTAssertTrue(app.alerts.staticTexts["Welcome"].exists)
        XCTAssertTrue(app.alerts.staticTexts["in San Francisco"].exists)
    }

}
