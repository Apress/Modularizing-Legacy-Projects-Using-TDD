//
//  CoreDataStack.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import CoreData

enum StorageType {
  case persistent, inMemory
}

class CoreDataStack {
    
    // MARK:- Variables
    private let modelName: String
    private let objectModel: NSManagedObjectModel?
    private let storageType: StorageType
    
    // MARK:- Lazy Variables
    lazy var storeContainer: NSPersistentContainer = {
        var container: NSPersistentContainer
        if let objectModel = self.objectModel {
            container = NSPersistentContainer(name: self.modelName, managedObjectModel: objectModel)
        }
        else {
            container = NSPersistentContainer(name: self.modelName)
        }
        if self.storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public lazy var context: NSManagedObjectContext = {
      return storeContainer.viewContext
    }()
    
    // MARK:- Initializer
    public init(name: String = "Books", objectModel: NSManagedObjectModel? = nil, storageType: StorageType = .persistent) {
        self.modelName = name
        self.objectModel = objectModel
        self.storageType = storageType
    }
    
    // MARK:- Functions
    public func saveContextIfNeeded() {
        if context.hasChanges {
            do {
              try context.save()
            }
            catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
