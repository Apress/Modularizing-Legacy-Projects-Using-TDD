//
//  CoreDataManager.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK:- Variables
    private var stack: CoreDataStack
    
    // MARK:- Singleton
    public static let shared = CoreDataManager(coreDataStack: CoreDataStack())
    
    // MARK:- Initializer
    public init(coreDataStack: CoreDataStack) {
        self.stack = coreDataStack
    }
    
    // MARK:- Functions
    
    public func create<T: Storable>(_ entityType: T.Type) -> T? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityType.entityName, in: stack.context) else {
            return nil
        }
        let entity = NSManagedObject(entity: entityDescription, insertInto: stack.context)
        stack.saveContextIfNeeded()
        return entity as? T
    }
    
    public func fetchAll<T: Storable>(_ entityType: T.Type, sort: NSSortDescriptor? = nil, limit: Int = 0, predicate: NSPredicate? = nil) -> [T]? {
        let request: NSFetchRequest<T> = T.fetchRequest()
        if let sort = sort {
            request.sortDescriptors = [sort]
        }
        if let predicate = predicate {
            request.predicate = predicate
        }
        request.fetchLimit = limit
        do {
            let results = try stack.context.fetch(request)
            return results
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        return nil
    }
    
    @discardableResult
    public func update<T: Storable>(_ entity: T?) -> T? {
        stack.saveContextIfNeeded()
        return entity
    }
    
}
