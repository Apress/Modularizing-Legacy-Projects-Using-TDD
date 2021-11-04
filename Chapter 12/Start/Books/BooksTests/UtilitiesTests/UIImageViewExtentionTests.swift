//
//  UIImageViewExtentionTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/7/21.
//

import XCTest
@testable import Books

class UIImageViewExtentionTests: XCTestCase {

    func testLoadImageMultiThreading() {
        // Given
        let queue = DispatchQueue(label: "com.ReaderWriterTests.DatabaseTests", attributes: .concurrent)
        let image = UIImageView()
        
        // When
        var expectations:[XCTestExpectation] = []
        for i in 0..<500 {
            let key = "Key\(i+1)"
            let exp = expectation(description: "Adding \(key) done")
            queue.async {
                image.load(url: URL(string: "https://storage.googleapis.com/du-prd/books/images/9781501171345.jpg")!)
                exp.fulfill()
            }
            expectations.append(exp)
        }
        
        for i in 0..<500 {
            let key = "Key\(i+1)"
            let exp = expectation(description: "Adding \(key) done")
            queue.async {
                image.load(url: URL(string: "https://storage.googleapis.com/du-prd/books/images/9781501171345.jpg")!)
                exp.fulfill()
            }
            expectations.append(exp)
        }
        
        wait(for: expectations, timeout: 10)
    }

}
