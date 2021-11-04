//
//  CoffeeDrinksModelTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import XCTest
@testable import Demo

class CoffeeDrinksModelTests: XCTestCase {

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
        
        // when
        let actualDrinks = coffeeDrinksModel.fetchAllCoffeDrinks()
        
        // then
        let coffeeDrink1 = actualDrinks![0]
        XCTAssertEqual(coffeeDrink1.name, "coffee1")
        XCTAssertEqual(coffeeDrink1.imageName, "black")
        XCTAssertEqual(coffeeDrink1.description, "desc1")
        
        let coffeeDrink2 = actualDrinks![1]
        XCTAssertEqual(coffeeDrink2.name, "coffee2")
        XCTAssertEqual(coffeeDrink2.imageName, "black")
        XCTAssertEqual(coffeeDrink2.description, "desc2")
    }
}
