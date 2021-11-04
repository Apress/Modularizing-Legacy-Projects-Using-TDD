//
//  Book+CoreDataProperties.swift
//  Books
//
//  Created by khaled mohamed el morabea on 08/05/2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var amazon_product_url: String?
    @NSManaged public var author: String?
    @NSManaged public var book_image: String?
    @NSManaged public var contributor: String?
    @NSManaged public var created_date: String?
    @NSManaged public var desc: String?
    @NSManaged public var publisher: String?
    @NSManaged public var title: String?
    @NSManaged public var buyLinks: NSSet?

}

// MARK: Generated accessors for buyLinks
extension Book {

    @objc(addBuyLinksObject:)
    @NSManaged public func addToBuyLinks(_ value: BuyLink)

    @objc(removeBuyLinksObject:)
    @NSManaged public func removeFromBuyLinks(_ value: BuyLink)

    @objc(addBuyLinks:)
    @NSManaged public func addToBuyLinks(_ values: NSSet)

    @objc(removeBuyLinks:)
    @NSManaged public func removeFromBuyLinks(_ values: NSSet)

}

extension Book : Identifiable {

}

extension Book: Storable {
    public static var entityName: String {
        String(describing: Self.self)
    }
}

extension Book {
    func convertToBookModel() -> BookModel {
        var model = BookModel(title: self.title ?? "", contributor: self.contributor ?? "", author: self.author ?? "", createdDate: self.created_date ?? "")
        model.amazonProductURL = self.amazon_product_url ?? ""
        model.bookImage = self.book_image ?? ""
        model.createdDate = self.created_date ?? ""
        model.bookDescription = self.desc ?? ""
        model.publisher = self.publisher ?? ""

        var links:[BuyLinkModel] = []
        guard let buylinks = self.buyLinks?.allObjects as? [BuyLink] else {
            return model
        }
        
        for buyLink in buylinks {
            let link = BuyLinkModel(name: BuyLinkModel.Name(rawValue: buyLink.name ?? "") ?? .amazon, url:buyLink.url ?? "")
            links.append(link)
        }
        
        model.buyLinks = links
        
        return model
    }
}
