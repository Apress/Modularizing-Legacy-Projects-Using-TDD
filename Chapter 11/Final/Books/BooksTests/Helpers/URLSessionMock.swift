//
//  URLSessionMock.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    public var stubbedData: Data?
    public var request: URLRequest?

    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.stubbedData
        self.request = request

        return URLSessionDataTaskMock {
            completionHandler(data, nil, nil)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
