//
//  NetworkLayerStub.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 01/06/2021.
//

import UIKit
@testable import Books

class NetworkLayerStub: NetworkLayer {
    var stubbedData:Data?
    
    init(stubbedData:Data) {
        self.stubbedData = stubbedData
    }
    
    override func executeRequest<T>(_ request: T, callBack: @escaping NetworkCompletion) where T : RequestProtocol {
        let jsonData = self.stubbedData
        callBack(jsonData, nil)
    }
}
