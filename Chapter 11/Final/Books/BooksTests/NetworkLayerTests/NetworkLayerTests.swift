//
//  NetworkLayerTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/26/21.
//

import XCTest
@testable import Books

class NetworkLayerTests: XCTestCase {

    func testExecutingSuccessfulRequest() {
        // Given
        let expectedData = "Sample Data".data(using: .utf8)
        let session = URLSessionMock()
        session.stubbedData = expectedData
        let network = NetworkLayer(session: session)
        let request = TestRequest()
        let env = APIEnvironment.production
        
        // When
        let excepectation = XCTestExpectation(description: "Request is done")
        var actualData: Data?
        var actualError: APIError?

        network.executeRequest(request, callBack: { data, error in
            actualData = data
            actualError = error
            excepectation.fulfill()
        })
        
        self.wait(for: [excepectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(session.request)
        XCTAssertEqual(session.request?.httpMethod, "GET")
        XCTAssertEqual(session.request?.httpBody, "Request Data".data(using: .utf8))
        XCTAssertEqual(session.request?.url, request.createURLRequest(with: env)?.url)
        XCTAssertEqual(expectedData, actualData)
        XCTAssertNil(actualError)
    }
    
    func testExecutingFailedRequest() {
        // Given
        let session = URLSessionMock()
        session.stubbedData = nil
        let network = NetworkLayer(session: session)
        let request = TestRequest()
        let env = APIEnvironment.production

        // When
        let excepectation = XCTestExpectation(description: "Request is done")
        var actualData: Data?
        var actualError: APIError?

        network.executeRequest(request, callBack: { data, error in
            actualData = data
            actualError = error
            excepectation.fulfill()
        })
        
        self.wait(for: [excepectation], timeout: 0.1)
        
        // Then
        XCTAssertNotNil(session.request)
        XCTAssertEqual(session.request?.httpMethod, "GET")
        XCTAssertEqual(session.request?.httpBody, "Request Data".data(using: .utf8))
        XCTAssertEqual(session.request?.url, request.createURLRequest(with: env)?.url)
        XCTAssertNil(actualData)
        XCTAssertEqual(actualError, .requestFailed)
    }
    
    func testExecutingRequestWithInvalidURL() {
        // Given
        let session = URLSessionMock()
        session.stubbedData = "Sample Data".data(using: .utf8)
        let network = NetworkLayer(session: session)
        let request = InvalidRequest()

        // When
        let excepectation = XCTestExpectation(description: "Request is done")
        var actualData: Data?
        var actualError: APIError?

        network.executeRequest(request, callBack: { data, error in
            actualData = data
            actualError = error
            excepectation.fulfill()
        })
        
        self.wait(for: [excepectation], timeout: 0.1)
        
        // Then
        XCTAssertNil(session.request)
        XCTAssertNil(actualData)
        XCTAssertEqual(actualError, .invalidRequest)
    }

}

struct InvalidRequest: RequestProtocol {
    var body: Data? {
        return nil
    }
    
    var path: String {
        return "INVALID PATH"
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var method:HTTPMethod {
        return .GET
    }
}
