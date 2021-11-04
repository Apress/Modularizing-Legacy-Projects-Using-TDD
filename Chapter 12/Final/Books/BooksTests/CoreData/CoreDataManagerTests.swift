//
//  CoreDataManagerTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import XCTest
import CoreData
@testable import Books

class CoreDataManagerTests: XCTestCase {
    
    // MARK:- Variables
    var manager: CoreDataManager!
    var stack: CoreDataStack!
    
    // MARK:- Setup
    override func setUp() {
        super.setUp()
        let testBundle = Bundle(for: type(of: self))
        let modelUrl = testBundle.url(forResource: "TestModel", withExtension: "momd")!
        let objectModel = NSManagedObjectModel(contentsOf: modelUrl)
        self.stack = CoreDataStack(name: "TestModel", objectModel: objectModel, storageType: .inMemory)
        self.manager = CoreDataManager(coreDataStack: stack)
    }

    override func tearDown() {
        super.tearDown()
        self.manager = nil
        self.stack = nil
    }

    func testSharedInstance() {
        // When
        let manager = CoreDataManager.shared
        
        // Then
        XCTAssertNotNil(manager)
    }
    
    func testCreateEntity() {
        // When
        let testModel = manager.create(TestEntity.self)
        
        // Then
        XCTAssertNotNil(testModel)
        XCTAssertEqual(stack.context.insertedObjects.count, 0)
    }
    
    func testFetchEntities() {
        // Given
        let testModel = manager.create(TestEntity.self)
        
        // When
        let models = manager.fetchAll(TestEntity.self)
        
        // Then
        XCTAssertNotNil(models)
        XCTAssertEqual(models?.count, 1)
        XCTAssertEqual(models?[0].objectID, testModel?.objectID)
    }
    
    func testUpdateEntity() {
        // Given
        let testModel = manager.create(TestEntity.self)
        testModel?.name = "Test"
        testModel?.number = 123
        
        // When
        manager.update(testModel)
        stack.context.rollback()
        
        // Then
        let updatedModel = manager.fetchAll(TestEntity.self)?[0]
        XCTAssertNotNil(updatedModel)
        XCTAssertEqual(updatedModel?.name, "Test")
        XCTAssertEqual(updatedModel?.number, 123)
    }
    
    func testFetchSorted() {
        // Given
        for i in 1...10 {
            let testModelOne = manager.create(TestEntity.self)
            testModelOne?.number = Int32(i)
            manager.update(testModelOne)
        }
        
        // When
        let sort = NSSortDescriptor(key: "number", ascending: false)
        let models = manager.fetchAll(TestEntity.self, sort: sort)
        
        // Then
        XCTAssertNotNil(models)
        XCTAssertEqual(models?.count, 10)
        XCTAssertEqual(models?[0].number, 10)
        XCTAssertEqual(models?[9].number, 1)
    }

    func testFetchWithLimit() {
        // Given
        for i in 1...10 {
            let testModelOne = manager.create(TestEntity.self)
            testModelOne?.number = Int32(i)
            manager.update(testModelOne)
        }
        
        // When
        let models = manager.fetchAll(TestEntity.self, limit: 5)
        
        // Then
        XCTAssertNotNil(models)
        XCTAssertEqual(models?.count, 5)
    }
    
    func testFetchWithPredicate() {
        // Given
        for i in 1...10 {
            let testModelOne = manager.create(TestEntity.self)
            testModelOne?.number = Int32(i)
            manager.update(testModelOne)
        }
        
        // When
        let predicate = NSPredicate(format: "number > 5")
        let models = manager.fetchAll(TestEntity.self, predicate: predicate)
        
        // Then
        XCTAssertNotNil(models)
        XCTAssertEqual(models?.count, 5)
    }
    
    
    func testDeleteEntity() {
        // Given
        let testModel = manager.create(TestEntity.self)
        
        // When
        manager.delete(testModel)
        let models = manager.fetchAll(TestEntity.self)
        
        // Then
        XCTAssertEqual(models?.count, 0)
    }

}
