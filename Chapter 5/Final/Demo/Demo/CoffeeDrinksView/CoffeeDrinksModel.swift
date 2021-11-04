//
//  CoffeeDrinksModel.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit

class CoffeeDrinksModel {
    private var dataSource:CoffeeDrinksDataSource?
    
    init(source:CoffeeDrinksDataSource?) {
        self.dataSource = source
    }
    
    public func fetchAllCoffeDrinks() ->[CoffeeDrink]? {
        guard let data = self.dataSource?.getData() else {
            return []
        }
        
        var drinks:[CoffeeDrink]?
        do {
            drinks = try JSONDecoder().decode([CoffeeDrink].self, from: data)
        } catch {
        }
        
        return drinks
    }
}
