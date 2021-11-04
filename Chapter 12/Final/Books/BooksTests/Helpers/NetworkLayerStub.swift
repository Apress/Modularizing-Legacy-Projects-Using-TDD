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
    
    public override func executeRequest<T: RequestProtocol>(_ request: T, callBack: @escaping (_ data:Data?, _ error: APIError?) -> Void) {
        let jsonData = self.stubbedData
        callBack(jsonData, nil)
    }
}
