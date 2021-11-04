//
//  CoffeeDrinksDataSourceStub.swift
//  DemoTests
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import UIKit
@testable import Demo

class CoffeeDrinksDataSourceStub: CoffeeDrinksDataSource {
    var stubbedDataJSON: String?
    
    init(stubbedDataJSON: String) {
        self.stubbedDataJSON = stubbedDataJSON
    }
    
    public override func getData() -> Data? {
        let jsonData = self.stubbedDataJSON?.data(using: .utf8)
        return jsonData
    }
}
