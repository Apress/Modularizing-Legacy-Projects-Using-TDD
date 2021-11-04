//
//  Validator.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import Foundation

internal enum ValidationError: Error {
    case emptyEmail
    case invalidEmail
    case tooLongEmail
    case emptyPassword
    case tooShortPassword
    case tooLongPassword
    case noSpecialCharacters
    
    var message: String {
        switch self {
        case .emptyEmail:
            return "Email can not be empty"
        case .invalidEmail:
            return "Please enter a valid email"
        case .tooLongEmail:
            return "Email can not be more than 100 characters"
        case .emptyPassword:
            return "Password can not be empty"
        case .tooShortPassword:
            return "Password must be 8 characters or more"
        case .tooLongPassword:
            return "Passeord must be less than 50 characters"
        case .noSpecialCharacters:
            return "Password must contain at least one special character"
        }
    }
}

struct Credentials {
    let email: String
    let password: String
}

class Validator {
    
    // MARK:- Type Alias
    
    typealias ValidationResult = (success: Bool, error: ValidationError?)
    
    // MARK:- Constants
    
    private static let maxEmailLength = 100
    private static let maxPasswordLength = 40
    private static let minPasswordLength = 8
    
    func validateCredentials(_ credentials: Credentials) -> ValidationResult {
        let emailValidation = isEmailValid(credentials.email)
        guard emailValidation.success else {
            return emailValidation
        }
        return isPasswordValid(credentials.password)
    }
    
    private func isEmailValid(_ email: String) -> ValidationResult {
        guard !email.isEmpty else {
            return (false, ValidationError.emptyEmail)
        }
        guard email.count <= Self.maxEmailLength else {
            return (false, ValidationError.tooLongEmail)
        }
        guard emailMatchesRegex(email) else {
            return (false, ValidationError.invalidEmail)
        }
        return (true, nil)
    }
    
    private func isPasswordValid(_ password: String) -> ValidationResult {
        guard !password.isEmpty else {
            return (false, ValidationError.emptyPassword)
        }
        if password.count < Self.minPasswordLength {
            return (false, ValidationError.tooShortPassword)
        }
        if password.count > Self.maxPasswordLength {
            return (false, ValidationError.tooLongPassword)
        }
        guard passwordHasSpecialCharacter(password) else {
            return (false, ValidationError.noSpecialCharacters)
        }
        return (true, nil)
    }
    
    private func emailMatchesRegex(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func passwordHasSpecialCharacter(_ password: String) -> Bool {
        let regex = ".*[^A-Za-z0-9].*"
        return password.range(of: regex, options: .regularExpression) != nil

    }
}
