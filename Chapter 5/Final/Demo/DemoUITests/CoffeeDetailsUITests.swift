//
//  CoffeeDetailsUITests.swift
//  DemoUITests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import XCTest

class CoffeeDetailsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testShowsCoffeeDrinkDetails() {
        let app = XCUIApplication()
        app.launchEnvironment = ["coffee_drinks_mocked": "coffee_drinks_mock"]
        app.launch()
        
        let coffeeCollectionView = app.collectionViews
        coffeeCollectionView.cells["coffee1"].tap()
        
        XCTAssertTrue(app.navigationBars["coffee1"].exists)
        XCTAssertEqual(app.textViews["desc"].value as? String, "description1")
    }

}
