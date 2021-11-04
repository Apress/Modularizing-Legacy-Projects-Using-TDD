//
//  MainViewDataSourceMock.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit
@testable import Demo

class MainViewDataSourceMock: MainViewDataSource {
    private var mockedData:[String] = []
    
    init(source:MainViewDataSource) {
    }
    
    init(mockedData:[String]) {
        self.mockedData = mockedData
    }
    
    override public func getCategoriesArray() -> [String]? {
        return self.mockedData
    }
}
