//
//  MainViewPresenter.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 06/02/2021.
//

import UIKit

class MainViewPresenter: NSObject {
    private var model:MainViewModel?

    init(model:MainViewModel) {
        self.model = model
    }
    
    public func fetchAllCategories() ->[String]? {
        return self.model?.fetchAllCategories()
    }
}
