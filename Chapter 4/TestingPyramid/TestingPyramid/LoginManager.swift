//
//  LoginManager.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import Foundation

class LoginManager {
    
    // MARK:- Type Aliases
    
    typealias Success = Bool
    typealias ErrorString = String
    typealias LoginCompletionHandler = (Success, ErrorString?) -> Void
    
    // MARK:- Variables
    private var validator: Validator
    private var databaseManager: DatabaseManager
    
    // MARK:- Singleton
    
    static let shared = LoginManager()
    
    // MARK:- Initializer
    
    init(databaseManager: DatabaseManager = DatabaseManager.shared) {
        self.validator = Validator()
        self.databaseManager = databaseManager
    }
    
    
    // MARK:- Public Functions
    
    func login(email: String, password: String, completionHandler: LoginCompletionHandler) {
        let credentials = Credentials(email: email, password: password)
        let validationResult = validator.validateCredentials(credentials)
        guard validationResult.success else {
            // TODO:- Handle error
            logFailedLogin()
            completionHandler(false, validationResult.error?.message)
            return
        }
        self.databaseManager.login(with: credentials) { (success, error) in
            guard success else {
                logFailedLogin()
                completionHandler(false, error)
                return
            }
            logSuccessfulLogin()
            completionHandler(true, nil)
        }
            
    }
    
    // MARK:- Helpers
    
    private func logSuccessfulLogin() {
        PersistenceManager.shared.incrementLogin(successful: true)
    }
    
    private func logFailedLogin() {
        PersistenceManager.shared.incrementLogin(successful: false)
    }
}
