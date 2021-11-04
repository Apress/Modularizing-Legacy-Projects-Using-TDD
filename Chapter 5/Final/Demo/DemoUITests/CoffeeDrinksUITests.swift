//
//  CoffeeDrinksUITests.swift
//  DemoUITests
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import XCTest

class CoffeeDrinksUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShowsAllCoffeeDrinks() {
        let app = XCUIApplication()
        app.launchEnvironment = ["coffee_drinks_stubbed": "coffee_drinks_stub"]
        app.launch()
        
        let coffeeCollectionView = app.collectionViews
        
        XCTAssertTrue(coffeeCollectionView.cells["coffee1"].exists, "Failed to show the first coffee item in plist")
        XCTAssertTrue(coffeeCollectionView.cells["coffee2"].exists, "Failed to show the second coffee item in plist")
    }
}
