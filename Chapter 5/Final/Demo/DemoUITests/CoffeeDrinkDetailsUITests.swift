//
//  CoffeeDrinkDetailsUITests.swift
//  DemoUITests
//
//  Created by khaled mohamed el morabea on 11/03/2021.
//

import XCTest

class CoffeeDrinkDetailsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowsCoffeeDrinkDetails() {
        let app = XCUIApplication()
        app.launchEnvironment = ["coffee_drinks_stubbed": "coffee_drinks_stub"]
        app.launch()
        
        let coffeeCollectionView = app.collectionViews
        coffeeCollectionView.cells["coffee1"].tap()
        
        XCTAssertTrue(app.navigationBars["coffee1"].exists)
        XCTAssertEqual(app.textViews["desc"].value as? String, "description1")
    }

}
