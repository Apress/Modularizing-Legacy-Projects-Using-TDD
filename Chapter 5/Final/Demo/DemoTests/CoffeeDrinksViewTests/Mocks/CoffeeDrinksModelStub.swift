//
//  CoffeeDrinksModelStub.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import UIKit
@testable import Demo

class CoffeeDrinksModelStub: CoffeeDrinksModel {
    var stubbedDrinks:[CoffeeDrink]?

    init(stubbedDrinks:[CoffeeDrink]) {
        super.init(source: nil)
        self.stubbedDrinks = stubbedDrinks
    }
    
    public override func fetchAllCoffeDrinks() ->[CoffeeDrink]? {
        return self.stubbedDrinks
    }
}
