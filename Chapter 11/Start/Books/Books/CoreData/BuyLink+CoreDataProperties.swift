//
//  BuyLink+CoreDataProperties.swift
//  Books
//
//  Created by khaled mohamed el morabea on 08/05/2021.
//
//

import Foundation
import CoreData


extension BuyLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyLink> {
        return NSFetchRequest<BuyLink>(entityName: "BuyLink")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var book: Book?

}

extension BuyLink : Identifiable {

}

extension BuyLink: Storable {
    public static var entityName: String {
        String(describing: Self.self)
    }
}
