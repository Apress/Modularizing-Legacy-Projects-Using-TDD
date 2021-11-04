//
//  CoffeeDetailsPresenterTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import XCTest
@testable import Demo

class CoffeeDetailsPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingDrinkName() {
        //Given
        let coffeeDetailsPresenter = CoffeeDetailsPresenter(drink:CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"))
                
        // when & then
        XCTAssertEqual(coffeeDetailsPresenter.getName(), "coffee1")
    }
    
    func testFetchingDrinkDescription() {
        //Given
        let coffeeDetailsPresenter = CoffeeDetailsPresenter(drink:CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"))
                
        // when & then
        XCTAssertEqual(coffeeDetailsPresenter.getDescription(), "desc1")
    }
    
    func testFetchingDrinkImageName() {
        //Given
        let coffeeDetailsPresenter = CoffeeDetailsPresenter(drink:CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"))
                
        // when & then
        XCTAssertEqual(coffeeDetailsPresenter.getImageName(), "black")
    }
}
