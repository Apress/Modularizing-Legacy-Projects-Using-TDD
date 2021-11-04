//
//  TestEntity+CoreDataProperties.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import CoreData
import Books

extension TestEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: String(describing: TestEntity.self))
    }

    @NSManaged public var name: String?
    @NSManaged public var number: Int32
}

extension TestEntity: Storable {
    public static var entityName: String {
        String(describing: Self.self)
    }
}
