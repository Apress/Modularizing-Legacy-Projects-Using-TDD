//
//  APIEnvironment.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import Foundation

struct APIEnvironment {
    let scheme: String
    let host: String
    let port: Int?
    let API_KEY: String
    
    static let production: APIEnvironment = .init(scheme: "https", host: "api.nytimes.com", port: nil, API_KEY: "YOUR_API_KEY")
    static let testing: APIEnvironment = .init(scheme: "http", host: "localhost", port: 8080, API_KEY: "KEY")
    
}
