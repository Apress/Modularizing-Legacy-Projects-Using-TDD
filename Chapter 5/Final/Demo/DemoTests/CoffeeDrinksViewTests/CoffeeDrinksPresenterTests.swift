//
//  CoffeeDrinksPresenterTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import XCTest
@testable import Demo

class CoffeeDrinksPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingDrinksCount() {
        //Given
        let drinks = [CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"),
                      CoffeeDrink(name: "coffee2",imageName: "black",description: "desc2")]
        let coffeeDrinksModel = CoffeeDrinksModelStub(stubbedDrinks: drinks)
        let coffeeDrinksPresenter = CoffeeDrinksPresenter(model:coffeeDrinksModel)
                
        // when & then
        XCTAssertEqual( coffeeDrinksPresenter.getDrinksCount(), 2)
    }
    
    func testFetchingDrinksName() {
        //Given
        let drinks = [CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"),
                      CoffeeDrink(name: "coffee2",imageName: "black",description: "desc2")]
        let coffeeDrinksModel = CoffeeDrinksModelStub(stubbedDrinks: drinks)
        let coffeeDrinksPresenter = CoffeeDrinksPresenter(model:coffeeDrinksModel)
                
        // when & then
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkName(index:0), "coffee1")
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkName(index:1), "coffee2")
    }
    
    func testFetchingDrinksImagesName() {
        //Given
        let drinks = [CoffeeDrink(name: "coffee1",imageName: "black",description: "desc1"),
                      CoffeeDrink(name: "coffee2",imageName: "black",description: "desc2")]
        let coffeeDrinksModel = CoffeeDrinksModelStub(stubbedDrinks: drinks)
        let coffeeDrinksPresenter = CoffeeDrinksPresenter(model:coffeeDrinksModel)
                
        // when & then
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkImageName(index:0), "black")
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkImageName(index:1), "black")
    }
}
