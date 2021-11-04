//
//  MainViewUITests.swift
//  DemoUITests
//
//  Created by khaled mohamed el morabea on 11/15/20.
//

import XCTest

class MainViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShowThreeMainFeatures() {
        let app = XCUIApplication()
        app.launch()

        let beansButton = app.buttons["beans_button"]
        let coffeTypesButton = app.buttons["coffeeDrinks_button"]
        let machinesTypesButton = app.buttons["machinesTypes_button"]

        XCTAssertEqual(beansButton.label, "Arabica vs robusta")
        XCTAssertEqual(coffeTypesButton.label, "All types of coffee drinks")
        XCTAssertEqual(machinesTypesButton.label, "All types of coffee machines")
    }
    
}
