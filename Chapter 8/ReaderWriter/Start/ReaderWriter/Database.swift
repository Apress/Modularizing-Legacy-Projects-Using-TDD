//
//  Database.swift
//  ReaderWriter
//
//  Created by Hassaan El-Garem on 5/25/21.
//

import Foundation

public class Database {

    // MARK:- Singelton
    public static let shared = Database()
    
    // MARK:- Initialzer
    private init() {}

    // MARK:- Private Variables
    internal var dictionary: [String:Any] = [:]

    // MARK:- Public Functions
    public func addObject(_ object: Any, for key: String) {
        dictionary[key] = object
    }

    public func removeObject(for key: String) {
        dictionary.removeValue(forKey: key)
    }

    public func object(for key: String) -> Any? {
        return dictionary[key]
    }

    public func recordsCount() -> Int {
        return dictionary.count
    }
    
    public func reset() {
        dictionary = [:]
    }

}
