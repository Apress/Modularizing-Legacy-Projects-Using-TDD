//
//  TestRequest.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import Foundation

import Foundation
@testable import Books

struct TestRequest: RequestProtocol {
    
    var method:HTTPMethod {
        return .GET
    }
        
    var body: Data? {
        return "Request Data".data(using: .utf8)
    }
    
    var path: String {
        return "/api/mock"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "offset", value: "20")]
    }
    
}
