//
//  LoginManagerTests.swift
//  TestingPyramidTests
//
//  Created by Hassaan El-Garem on 1/29/21.
//

import XCTest
@testable import TestingPyramid

class LoginManagerTests: XCTestCase {

    override func setUpWithError() throws {
        PersistenceManager.shared.clear()
    }
    
    func testInvalidCredentialsLogin() {
        // Given
        let databaseManager = TestDatabaseManager()
        let persistenceManager = PersistenceManager.shared
        let manager = LoginManager(databaseManager: databaseManager)
        
        // That
        let expectation = self.expectation(description: "Login finished")
        
        // When
        manager.login(email: "invalid", password: "invalid") { (success, error) in
            // Then
            XCTAssertFalse(success, "Login should not be successful")
            XCTAssertEqual(error, ValidationError.invalidEmail.message, "Wrong error returned from login")
            expectation.fulfill()
        }
        
        // Then
        self.wait(for: [expectation], timeout: 2)
        XCTAssertEqual(persistenceManager.failedLoginsCount, 1, "Failed login counts should be incremented")
        XCTAssertEqual(persistenceManager.successfulLoginsCount, 0, "Successful login counts should not be incremented")
        XCTAssertEqual(databaseManager.queriesCount, 0, "Database should not be queried")
    }
    
    func testIncorrectCredentialsLogin() {
        // Given
        let databaseManager = TestDatabaseManager(databaseFilename: "testAccounts")
        let persistenceManager = PersistenceManager.shared
        let manager = LoginManager(databaseManager: databaseManager)
        
        // That
        let expectation = self.expectation(description: "Login finished")
        
        // When
        manager.login(email: "test@test.com", password: "Incorrect!") { (success, error) in
            // Then
            XCTAssertFalse(success, "Login should not be successful")
            XCTAssertEqual(error, DatabaseError.credentialMismatch.message, "Wrong error returned from login")
            expectation.fulfill()
        }
        
        // Then
        self.wait(for: [expectation], timeout: 2)
        XCTAssertEqual(persistenceManager.failedLoginsCount, 1, "Failed login counts should be incremented")
        XCTAssertEqual(persistenceManager.successfulLoginsCount, 0, "Successful login counts should not be incremented")
        XCTAssertEqual(databaseManager.queriesCount, 1, "Database should be queried")
    }
    
    func testSuccessfulLogin() {
        // Given
        let databaseManager = TestDatabaseManager(databaseFilename: "testAccounts")
        let persistenceManager = PersistenceManager.shared
        let manager = LoginManager(databaseManager: databaseManager)
        
        // That
        let expectation = self.expectation(description: "Login finished")
        
        // When
        manager.login(email: "test@test.com", password: "!2345678") { (success, error) in
            // Then
            XCTAssertTrue(success, "Login should be successful")
            XCTAssertNil(error, "No error should be returned from login")
            expectation.fulfill()
        }
        
        // Then
        self.wait(for: [expectation], timeout: 2)
        XCTAssertEqual(persistenceManager.failedLoginsCount, 0, "Failed login counts should not be incremented")
        XCTAssertEqual(persistenceManager.successfulLoginsCount, 1, "Successful login counts should be incremented")
        XCTAssertEqual(databaseManager.queriesCount, 1, "Database should be queried")
    }

}

class TestDatabaseManager: DatabaseManager {
    var queriesCount: Int = 0
    
    override func login(with credentials: Credentials, completionHandler: (DatabaseManager.Success, DatabaseManager.ErrorString?) -> Void) {
        queriesCount += 1
        super.login(with: credentials, completionHandler: completionHandler)
    }
}
