//
//  BookRequest.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import Foundation

struct BooksRequest: RequestProtocol {
    
    var path: String {
        return "/svc/books/v3/lists/overview.json"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "offset", value: "20"), URLQueryItem(name: "api-key", value: NetworkLayer.environment.API_KEY)]
    }
    
    var method:HTTPMethod {return .GET}
    
    var body: Data? {return nil}
}
