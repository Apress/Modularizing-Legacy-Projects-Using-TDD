//
//  CoffeeDrinksDataSource.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit

class CoffeeDrinksDataSource {
    func plistDataSourcePath() -> String? {
        var fileName = "coffee_drinks"
        // UITests
        if let stubbedFileName = ProcessInfo.processInfo.environment["coffee_drinks_stubbed"] {
            fileName = stubbedFileName
        }
        
        return Bundle.main.path(forResource: fileName, ofType: "plist")
    }
    
    public func getData() -> Data? {
        let dataPath = plistDataSourcePath()
        guard let path = dataPath, let dataArray = NSArray(contentsOfFile:path) else {
            return nil
        }
        
        var data:Data?
        do {
            data = try JSONSerialization.data(withJSONObject: dataArray)
        }catch {
            print("JSON serialization failed:  \(error)")
        }
        
        return data
    }
}
