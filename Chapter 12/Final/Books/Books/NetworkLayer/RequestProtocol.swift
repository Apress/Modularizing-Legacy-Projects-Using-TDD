//
//  RequestProtocol.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE

}

protocol RequestProtocol {
    var method: HTTPMethod { get }
    var body: Data? { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension RequestProtocol {
    func createURLRequest(with environment: APIEnvironment) -> URLRequest? {
        guard let url = createURL(with: environment) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
    
    private func createURL(with environment: APIEnvironment) -> URL? {
        var components = URLComponents()
        components.scheme = environment.scheme
        components.host = environment.host
        components.port = environment.port
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
