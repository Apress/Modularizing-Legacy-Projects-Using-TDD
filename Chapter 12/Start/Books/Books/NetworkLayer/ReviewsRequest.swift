//
//  ReviewsRequest.swift
//  Books
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import UIKit

struct ReviewsRequest: RequestProtocol {
    var title:String?

    init(title:String) {
        self.title = title
    }
    
    var path: String {
        return "/svc/books/v3/reviews.json"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "title", value: self.title), URLQueryItem(name: "api-key", value: NetworkLayer.environment.API_KEY)]
    }
    
    var method:HTTPMethod {return .GET}
    
    var body: Data? {return nil}
}
