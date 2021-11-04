//
//  CoffeeDrinksIntegrationTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import XCTest
@testable import Demo

class CoffeeDrinksIntegrationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingAllCoffeeDrinks() {
        //Given
        let expectedDrinks = """
        [
            {
                "name": "coffee1",
                "image_name": "black",
                "desc": "desc1"
            },
            {
                "name": "coffee2",
                "image_name": "black",
                "desc": "desc2"
            }
        ]
        """
        let coffeeDrinksDataSource = CoffeeDrinksDataSourceStub(stubbedDataJSON:expectedDrinks)
        let coffeeDrinksModel = CoffeeDrinksModel(source: coffeeDrinksDataSource)
        let coffeeDrinksPresenter = CoffeeDrinksPresenter(model:coffeeDrinksModel)
        
        // when & then
        XCTAssertEqual( coffeeDrinksPresenter.getDrinksCount(), 2)

        XCTAssertEqual(coffeeDrinksPresenter.getDrinkName(index:0), "coffee1")
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkImageName(index:0), "black")

        XCTAssertEqual(coffeeDrinksPresenter.getDrinkName(index:1), "coffee2")
        XCTAssertEqual(coffeeDrinksPresenter.getDrinkImageName(index:1), "black")
    }

}
