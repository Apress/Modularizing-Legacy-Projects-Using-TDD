//
//  FavoritesManagerTests.swift
//  BooksTests
//
//  Created by Hassaan El-Garem on 6/23/21.
//

import XCTest
@testable import Books
import CoreData

class FavoritesManagerTests: XCTestCase {
    
    // MARK:- Variables
    var favoritesManager: FavoritesManager!
    var coredataManager: CoreDataManager!
    var stack: CoreDataStack!
    
    // MARK:- Setup
    override func setUp() {
        super.setUp()
        self.stack = CoreDataStack(storageType: .inMemory)
        self.coredataManager = CoreDataManager(coreDataStack: stack)
        self.favoritesManager = FavoritesManager(coredataManager: coredataManager)
    }

    override func tearDown() {
        super.tearDown()
        self.favoritesManager = nil
        self.coredataManager = nil
        self.stack = nil
    }
    
    // MARK:- Tests
    func testAddingBookWith() {
        // Given
        let buyLink = BuyLinkModel(name: .amazon, url: "URL")
        var book = BookModel(title: "BookTitle", contributor: "Contributor", author: "Author", createdDate: "2021-05-26 22:10:24")
        book.amazonProductURL = "Amazon"
        book.bookImage = "Image"
        book.bookDescription = "Description"
        book.publisher = "Publisher"
        book.buyLinks = [buyLink]
        
        // When
        favoritesManager.addFavorite(book)
        
        // Then
        let books = coredataManager.fetchAll(Book.self)
        XCTAssertNotNil(books)
        XCTAssertEqual(books?.count, 1)
        let retrivedBook = books![0]
        XCTAssertEqual(retrivedBook.title, book.title)
        XCTAssertEqual(retrivedBook.contributor, book.contributor)
        XCTAssertEqual(retrivedBook.author, book.author)
        XCTAssertEqual(retrivedBook.created_date, book.createdDate)
        XCTAssertEqual(retrivedBook.amazon_product_url, book.amazonProductURL)
        XCTAssertEqual(retrivedBook.book_image, book.bookImage)
        XCTAssertEqual(retrivedBook.desc, book.bookDescription)
        XCTAssertEqual(retrivedBook.publisher, book.publisher)
        XCTAssertEqual(retrivedBook.buyLinks?.count, 1)
        let link = retrivedBook.buyLinks?.allObjects[0] as? BuyLink
        XCTAssertEqual(link?.name, buyLink.name.rawValue)
        XCTAssertEqual(link?.url, buyLink.url)
    }
    
    func testFetchingFavoritesSorted() {
        // Given
        let book1 = BookModel(title: "Book1", contributor: "Contributor", author: "Author", createdDate: "2021-05-01 22:00:00")
        let book2 = BookModel(title: "Book2", contributor: "Contributor", author: "Author", createdDate: "2021-05-02 22:00:00")
        let book3 = BookModel(title: "Book3", contributor: "Contributor", author: "Author", createdDate: "2021-05-03 22:00:00")

        favoritesManager.addFavorite(book1)
        favoritesManager.addFavorite(book3)
        favoritesManager.addFavorite(book2)
        
        // When
        let favorites = favoritesManager.fetchAllFavorites()
        
        // Then
        XCTAssertEqual(favorites.count, 3)
        XCTAssertEqual(favorites[0].title, "Book3")
        XCTAssertEqual(favorites[1].title, "Book2")
        XCTAssertEqual(favorites[2].title, "Book1")
    }
    
    func testDeletingFavorite() {
        // Given
        let book1 = BookModel(title: "Book1", contributor: "Contributor", author: "Author", createdDate: "2021-05-01 22:00:00")
        let book2 = BookModel(title: "Book2", contributor: "Contributor", author: "Author", createdDate: "2021-05-02 22:00:00")

        favoritesManager.addFavorite(book1)
        favoritesManager.addFavorite(book2)
        
        // When
        favoritesManager.deleteFavorite(book1)
        
        // Then
        let favorites = favoritesManager.fetchAllFavorites()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites[0].title, "Book2")
    }
}
