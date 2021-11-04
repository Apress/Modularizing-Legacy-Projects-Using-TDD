//
//  Storable.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import CoreData

public protocol Storable: NSManagedObject {
    static var entityName: String {get}
    static func fetchRequest() -> NSFetchRequest<Self>
}
