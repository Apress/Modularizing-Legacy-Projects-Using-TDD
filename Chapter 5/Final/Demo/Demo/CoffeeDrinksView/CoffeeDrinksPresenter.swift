//
//  CoffeeDrinksPresenter.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit

class CoffeeDrinksPresenter {
    private var model:CoffeeDrinksModel?
    var drinks:[CoffeeDrink]?

    init(model:CoffeeDrinksModel?) {
        self.model = model
        self.drinks = self.model?.fetchAllCoffeDrinks()
    }
    
    public func getDrinksCount() -> Int {
        self.drinks?.count ?? 0
    }
    
    public func getDrinkName(index:Int) -> String? {
        guard let drink = self.drinks?[index] else {
            return nil
        }
        
        return drink.name
    }
    
    public func getDrinkImageName(index:Int) -> String? {
        guard let drink = self.drinks?[index] else {
            return nil
        }
        
        return drink.imageName
    }
    
    public func getDrink(index:Int) -> CoffeeDrink? {
        guard let drink = self.drinks?[index] else {
            return nil
        }
        
        return drink
    }
}
