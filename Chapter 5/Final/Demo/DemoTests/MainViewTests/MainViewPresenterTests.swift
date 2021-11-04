//
//  MainViewPresenterTests.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 06/02/2021.
//

import XCTest
@testable import Demo

class MainViewPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingAllCategories() {
        //Given
        let expectedCategories = ["data1", "data2", "data3"]
        let mainViewModel = MainViewModelMock(mockedData: expectedCategories)
        let mainViewPresenter = MainViewPresenter(model:mainViewModel)
        
        // when
        let actualCategories = mainViewPresenter.fetchAllCategories()
        
        // then
        XCTAssertEqual(expectedCategories, actualCategories)
    }

}
