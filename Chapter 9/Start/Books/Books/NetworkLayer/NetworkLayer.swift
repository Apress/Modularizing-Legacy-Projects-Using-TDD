//
//  NetworkLayer.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/06/2021.
//

import UIKit

class NetworkLayer {
    let API_KEY = "YOUR_API_KEY"
    let bestSellerBooks = "/svc/books/v3/lists/overview.json"
    
    static func isTesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("TESTING")
    }
    
    func getHost() -> String {
        if Self.isTesting() {
            return "localhost"
        } else {
            return "api.nytimes.com"
        }
    }
    
    func getScheme() -> String {
        if Self.isTesting() {
            return "http"
        } else {
            return "https"
        }
    }
    
    
    public func executeNetworkRequest(callBack: @escaping (_ data:Data?) -> Void) {
        assert(API_KEY != "YOUR_API_KEY", "You need to replace \"YOUR_API_KEY\" with an actual API key. Check the project's README for steps on how to obtain one.")
        var components = URLComponents()
        components.scheme = getScheme()
        components.host = getHost()
        if Self.isTesting() {
            components.port = 8080
        }
        components.path = bestSellerBooks
        components.queryItems = [URLQueryItem(name: "api-key", value: API_KEY), URLQueryItem(name: "offset", value: "20")]

        guard let url = components.url else {
            callBack(nil)
            preconditionFailure("Failed to construct URL")
        }

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data else {
                callBack(nil)
                return
            }
            
            callBack(data)
        }

        task.resume()
    }
}
