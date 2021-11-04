//
//  NetworkLayer.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/06/2021.
//

import UIKit

typealias NetworkCompletion = (Data?, APIError?) -> Void

enum APIError: Error {
    case requestFailed
    case invalidRequest
}

class NetworkLayer {
    
    // MARK:- Variables
    let session: URLSession
    static var environment: APIEnvironment {
        return isTesting() ? .testing : .production
    }
    
    // MARK:- Initialzier
    
    init(session:URLSession = .shared) {
        self.session = session
    }
    
    // MARK:- Public Functions
    
    public func executeRequest<T: RequestProtocol>(_ request: T, callBack: @escaping NetworkCompletion) {
        assert(Self.environment.API_KEY != "YOUR_API_KEY", "You need to replace \"YOUR_API_KEY\" with an actual API key. Check the project's README for steps on how to obtain one.")
        guard let urlRequest = request.createURLRequest(with: Self.environment) else {
            callBack(nil, .invalidRequest)
            return
        }
        
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                callBack(nil, .requestFailed)
                return
            }
            
            callBack(data, nil)
        }

        task.resume()
    }
    
    // MARK:- Helper Functions
    
    static func isTesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("TESTING")
    }
}

