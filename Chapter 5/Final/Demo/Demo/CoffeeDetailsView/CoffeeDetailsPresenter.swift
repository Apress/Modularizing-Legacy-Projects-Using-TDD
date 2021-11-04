//
//  CoffeeDetailsPresenter.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import UIKit

class CoffeeDetailsPresenter {
    private var drink:CoffeeDrink?
    
    init(drink:CoffeeDrink?) {
        self.drink = drink
    }
    
    public func getName() -> String? {
        guard let drink = self.drink else {
            return nil
        }
        return drink.name
    }
    
    public func getImageName() -> String? {
        guard let drink = self.drink else {
            return nil
        }
        return drink.imageName
    }
    
    public func getDescription() -> String? {
        guard let drink = self.drink else {
            return nil
        }
        return drink.description
    }
}
