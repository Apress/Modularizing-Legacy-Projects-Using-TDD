//
//  CoreDataStackTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import XCTest
import CoreData
@testable import Books

class CoreDataStackTests: XCTestCase {

    func testDefaultStoreName() {
        // Given
        let stack = CoreDataStack()
        
        // When
        let container = stack.storeContainer
        
        // Then
        XCTAssertEqual(container.name, "Books")
    }
    
    func testCustomStoreName() {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let modelUrl = testBundle.url(forResource: "TestModel", withExtension: "momd")!
        let objectModel = NSManagedObjectModel(contentsOf: modelUrl)
        let stack = CoreDataStack(name: "TestModel", objectModel: objectModel)
        
        // When
        let container = stack.storeContainer
        
        // Then
        XCTAssertEqual(container.name, "TestModel")
    }
    
    func testPersistentStoreType() {
        // Given
        let stack = CoreDataStack(storageType: .persistent)
        
        // When
        let container = stack.storeContainer
        
        // Then
        XCTAssertEqual(container.persistentStoreDescriptions[0].type, NSSQLiteStoreType)
    }

    func testInMemoryStoreType() {
        // Given
        let stack = CoreDataStack(storageType: .inMemory)
        
        // When
        let container = stack.storeContainer
        
        // Then
        XCTAssertEqual(container.persistentStoreDescriptions[0].type, NSInMemoryStoreType)
    }
    
    func testContext() {
        // Given
        let stack = CoreDataStack(storageType: .inMemory)
        
        // When
        let context = stack.context
        
        // Then
        XCTAssertNotNil(context)
        XCTAssertEqual(context.concurrencyType, .mainQueueConcurrencyType)
    }
    
    func testSavingContextIfNeeded() {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let modelUrl = testBundle.url(forResource: "TestModel", withExtension: "momd")!
        let objectModel = NSManagedObjectModel(contentsOf: modelUrl)
        let stack = CoreDataStack(name: "TestModel", objectModel: objectModel, storageType: .inMemory)
        let context = stack.context
        let _ = TestEntity(context: context)
        
        // Expected
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context, handler: nil)

        // When
        stack.saveContextIfNeeded()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
