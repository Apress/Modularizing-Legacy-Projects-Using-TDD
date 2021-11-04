//
//  DatabaseManager.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 1/28/21.
//

import Foundation

internal enum DatabaseError: Error {
    case databaseError
    case credentialMismatch
    case accountMissing
    
    var message: String {
        switch self {
        case .databaseError:
            return "Error connecing to database"
        case .credentialMismatch:
            return "Email and password do not match"
        case .accountMissing:
            return "No account found for this email"
        }
    }
}

class DatabaseManager {
    
    // MARK:- Constants
    
    private static let kDefaultDatabaseFilename = "accounts"
    
    // MARK:- Type Aliases
    
    typealias Success = Bool
    typealias ErrorString = String
    typealias LoginCompletionHandler = (Success, ErrorString?) -> Void
    private typealias Accounts = [String:String]
    private typealias DatabaseResultCompletionHandler = (Accounts?) -> Void
    
    // MARK:- Singleton
    
    static let shared = DatabaseManager()
    
    // MARK:- Initializer
    
    init(databaseFilename: String = kDefaultDatabaseFilename) {
        self.databaseFilename = databaseFilename
    }
    
    // MARK:- Private Variables
    
    private let databaseFilename: String
    
    // MARK:- Public Functions
    
    func login(with credentials: Credentials, completionHandler: LoginCompletionHandler) {
        readDatabase { (accounts) in
            guard let accounts = accounts else {
                completionHandler(false, DatabaseError.databaseError.message)
                return
            }
            guard let passwordSaved = accounts[credentials.email] else {
                completionHandler(false, DatabaseError.accountMissing.message)
                return
            }
            guard passwordSaved == credentials.password else {
                completionHandler(false, DatabaseError.credentialMismatch.message)
                return
            }
            completionHandler(true, nil)
        }
    }
    
    // MARK:- Private Functions
    
    private func readDatabase(_ completionHandler: DatabaseResultCompletionHandler) {

        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        guard let plistPath = Bundle.main.path(forResource: self.databaseFilename, ofType: "plist"),
              let plistXML = FileManager.default.contents(atPath: plistPath) else {
            print("Error reading file")
            completionHandler(nil)
            return
        }
        do {
            let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? Accounts
            completionHandler(plistData)
            return

        } catch {
            print("Error decoding plist: \(error))")
            completionHandler(nil)
        }
    }
    
}
