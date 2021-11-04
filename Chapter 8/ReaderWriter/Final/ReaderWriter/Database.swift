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

    // MARK:- Private Variables
    internal var dictionary: [String:Any] = [:]
    private let queue = DispatchQueue(label: "com.ReaderWriter.Database")
    
    // MARK:- Initialzer
    init() {}

    // MARK:- Public Functions
    public func addObject(_ object: Any, for key: String) {
        queue.sync {
            dictionary[key] = object
        }
    }

    public func removeObject(for key: String) {
        queue.sync {
            _ = dictionary.removeValue(forKey: key)
        }
    }

    public func object(for key: String) -> Any? {
        queue.sync {
            return dictionary[key]
        }
    }

    public func recordsCount() -> Int {
        queue.sync {
            return dictionary.count
        }
    }
    
    public func reset() {
        queue.sync {
            dictionary = [:]
        }
    }
}
