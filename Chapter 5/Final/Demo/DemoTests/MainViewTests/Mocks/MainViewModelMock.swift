//
//  MainViewModelMock.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit
@testable import Demo

class MainViewModelMock: MainViewModel {
    private var mockedData:[String] = []
    
    init(mockedData:[String]) {
        super.init(source: nil)
        self.mockedData = mockedData
    }
    
    override public func fetchAllCategories() ->[String] {
        return self.mockedData
    }
}
