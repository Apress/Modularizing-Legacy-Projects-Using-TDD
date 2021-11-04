//
//  DatabaseTests.swift
//  ReaderWriterTests
//
//  Created by Hassaan El-Garem on 5/25/21.
//

import XCTest
@testable import ReaderWriter

class DatabaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Database.shared.reset()
    }
    
    override func tearDown() {
        Database.shared.reset()
    }
    
    
    func testAddingObject() {
        // Given
        let expectedValue = "TestValue"
        let key = "Key"
        let database = Database.shared
        
        // When
        database.addObject(expectedValue, for: key)
        
        // Then
        let value = database.dictionary[key] as? String
        XCTAssertEqual(expectedValue, value)
    }
    
    func testRetrievingObject() {
        // Given
        let expectedValue = "TestValue"
        let key = "Key"
        let database = Database.shared
        database.dictionary[key] = expectedValue
        
        // When
        let value = database.object(for: key) as? String
        
        // Then
        XCTAssertEqual(expectedValue, value)
    }
    
    func testRemovingObject() {
        // Given
        let database = Database.shared
        for i in 0..<5 {
            database.dictionary["Key-\(i)"] = "Value"
        }
        
        // When
        database.removeObject(for: "Key-0")
        
        // Then
        let count = database.dictionary.count
        XCTAssertEqual(count, 4)
    }
    
    func testRecordsCount() {
        // Given
        let database = Database.shared
        for i in 0..<5 {
            database.dictionary["Key-\(i)"] = "Value"
        }
        
        // When
        let count = database.recordsCount()
        
        // Then
        XCTAssertEqual(count, 5)
    }
    
    func testReadWriteDataRace() {
        // Given
        let queue = DispatchQueue(label: "com.ReaderWriterTests.DatabaseTests", attributes: .concurrent)
        let database = Database.shared
        database.addObject("InitialValue", for: "InitialKey")
        
        // When
        var expectations:[XCTestExpectation] = []
        for i in 0..<10 {
            let key = "Key\(i+1)"
            let exp = expectation(description: "Adding \(key) done")
            queue.async {
                database.addObject("Test", for: key)
                exp.fulfill()
            }
            expectations.append(exp)
        }
        for i in 0..<10 {
            let key = "Key\(i+1)"
            let exp = expectation(description: "Adding \(key) done")
            queue.async {
                let _ = database.object(for: "InitialKey")
                exp.fulfill()
            }
            expectations.append(exp)
        }
        wait(for: expectations, timeout: 10)
        
        
        // Then
        let count = database.recordsCount()
        XCTAssertEqual(count, 11)
    }
    
}
