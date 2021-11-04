//
//  MainViewModel.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 06/02/2021.
//

import UIKit

class MainViewModel: NSObject {
    private var dataSource:MainViewDataSource?

    init(source:MainViewDataSource?) {
        self.dataSource = source
    }
    
    public func fetchAllCategories() ->[String]? {
        guard let data = self.dataSource?.getData() else {
            return nil
        }
        
        var categories:[String]?
        let decoder = JSONDecoder()
        do {
            categories = try decoder.decode([String].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return categories
    }
}
