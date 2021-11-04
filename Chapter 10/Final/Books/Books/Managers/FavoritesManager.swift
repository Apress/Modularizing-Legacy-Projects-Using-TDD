//
//  FavoritesManager.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import Foundation

class FavoritesManager {
    
    // MARK:- Variables
    private var coredataManager: CoreDataManager
    
    // MARK:- Singleton
    public static let shared = FavoritesManager()
    
    // MARK:- Initializer
    init(coredataManager: CoreDataManager = .shared) {
        self.coredataManager = coredataManager
    }
    
    // MARK:- Public Functions
    func fetchAllFavorites() -> [Book] {
        let sort = NSSortDescriptor(key: "created_date", ascending: false)
        return coredataManager.fetchAll(Book.self, sort: sort) ?? []
    }
    
    func addFavorite(_ model: BookModel) {
        guard let book = coredataManager.create(Book.self) else {
            return
        }
        book.title = model.title
        book.amazon_product_url = model.amazonProductURL
        book.author = model.author
        book.book_image = model.bookImage
        book.contributor = model.contributor
        book.created_date = model.createdDate
        book.desc = model.bookDescription
        book.publisher = model.publisher

        let links:NSMutableSet? = []
        guard let buyLinks = model.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if let link = coredataManager.create(BuyLink.self) {
                link.url = buyLink.url
                link.name = buyLink.name.rawValue
                link.book = book
                links?.add(link)
            }
        }
        
        book.buyLinks = links
        coredataManager.update(book)
    }
    
    // MARK:- Private Helpers
    func getBook(from model: BookModel) -> Book? {
        let predicate = NSPredicate(format: "title == %@", model.title ?? "")
        let results = coredataManager.fetchAll(Book.self, limit: 1, predicate: predicate)
        guard let books = results, books.count == 1 else {
            return nil
        }
        return books[0]
    }
}
