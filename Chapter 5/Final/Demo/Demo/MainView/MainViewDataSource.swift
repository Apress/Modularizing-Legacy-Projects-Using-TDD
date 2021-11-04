//
//  MainViewDataSource.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 06/02/2021.
//

import UIKit

class MainViewDataSource: NSObject {
    func plistDataSourcePath() -> String? {
        return Bundle.main.path(forResource: "Categoris", ofType: "plist")
    }
    
    public func getData() -> Data? {
        let dataPath = plistDataSourcePath()
        guard let path = dataPath else {
            return nil
        }
        
        return Data(base64Encoded: path)
    }
}
