//
//  ValidatorTests.swift
//  TestingPyramidTests
//
//  Created by Hassaan El-Garem on 11/10/20.
//

import XCTest
@testable import TestingPyramid

class ValidatorTests: XCTestCase {

    func testValidCredentials() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "valid@valid.com", password: "Password!")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertTrue(result.success)
        XCTAssertNil(result.error)
    }
    
    func testEmptyEmail() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "", password: "Password!")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .emptyEmail)
    }
    
    func testInvalidEmail() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "invalid", password: "Password!")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .invalidEmail)
    }
    
    func testTooLongEmail() {
        // Given
        let validator = Validator()
        let email = randomString(100) + "@valid.com"
        let password = "Password!"
        let credentials = Credentials(email: email, password: password)
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .tooLongEmail)
    }
    
    func testEmptyPassword() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "valid@valid.com", password: "")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .emptyPassword)
    }
    
    func testShortPassword() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "valid@valid.com", password: "1234!")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .tooShortPassword)
    }
    
    func testLongPassword() {
        // Given
        let validator = Validator()
        let email = "valid@valid.com"
        let password = randomString(41)
        let credentials = Credentials(email: email, password: password)
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .tooLongPassword)
    }
    
    func testNoSpecialCharacterPassword() {
        // Given
        let validator = Validator()
        let credentials = Credentials(email: "valid@valid.com", password: "12345678")
        
        // When
        let result = validator.validateCredentials(credentials)
        
        // Then
        XCTAssertFalse(result.success)
        XCTAssertEqual(result.error, .noSpecialCharacters)
    }
    
    // MARK:- Helpers
    
    func randomString(_ count: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<count).map{ _ in letters.randomElement()! })
    }

}
