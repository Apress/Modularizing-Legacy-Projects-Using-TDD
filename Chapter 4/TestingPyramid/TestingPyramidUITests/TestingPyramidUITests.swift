//
//  TestingPyramidUITests.swift
//  TestingPyramidUITests
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import XCTest

class TestingPyramidUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testInvalidLogin() throws {
        // Initial state
        let title = app.staticTexts[AccessibilityIdentifiers.kLoginWelcomeLabelIdentifier]
        let emailTextField = app.textFields[AccessibilityIdentifiers.kLoginEmailTextFieldIdentifier]
        let passwordTextField = app.textFields[AccessibilityIdentifiers.kLoginPasswordTextFieldIdentifier]
        let loginButton = app.buttons[AccessibilityIdentifiers.kLoginButtonIdentifier]
        
        XCTAssertTrue(title.exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
        
        // Invalid login
        
        loginButton.tap()
        
        // Then
        let alert = app.alerts.element
        let alertExists = alert.waitForExistence(timeout: 5)
        XCTAssertTrue(alertExists)
        XCTAssertEqual(alert.label, "Login Error")
        XCTAssertTrue(alert.staticTexts["Email can not be empty"].exists)
    }
    
    func testValidLogin() throws {
        // Initial state
        let title = app.staticTexts[AccessibilityIdentifiers.kLoginWelcomeLabelIdentifier]
        let emailTextField = app.textFields[AccessibilityIdentifiers.kLoginEmailTextFieldIdentifier]
        let passwordTextField = app.textFields[AccessibilityIdentifiers.kLoginPasswordTextFieldIdentifier]
        let loginButton = app.buttons[AccessibilityIdentifiers.kLoginButtonIdentifier]
        
        XCTAssertTrue(title.exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
        
        // Valid login
        emailTextField.tap()
        emailTextField.typeText("valid@valid.com")
        title.tap()
        passwordTextField.tap()
        passwordTextField.typeText("Password!")
        title.tap()
        loginButton.tap()
        
        // Then
        let statisticsTitle = app.staticTexts[AccessibilityIdentifiers.kStatisticsTitleLabelIdentifier]
        let failedLabel = app.staticTexts[AccessibilityIdentifiers.kFailedCountLabelIdentifier]
        let successfulLabel = app.staticTexts[AccessibilityIdentifiers.kSuccessfulCountLabelIdentifier]
        XCTAssertTrue(statisticsTitle.exists)
        XCTAssertTrue(failedLabel.exists)
        XCTAssertTrue(successfulLabel.exists)
    }
}
