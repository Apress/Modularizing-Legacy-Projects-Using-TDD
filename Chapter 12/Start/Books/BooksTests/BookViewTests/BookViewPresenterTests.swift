//
//  BookViewPresenterTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import XCTest
@testable import Books

class BookViewPresenterTests: XCTestCase {

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
    
    func testFetchingSavedBooks() throws {
        // Given
        let buyLink = BuyLinkModel(name: .amazon, url: "URL")
        var book = BookModel(title: "BookTitle", contributor: "Contributor", author: "Author", createdDate: "2021-05-26 22:10:24")
        book.amazonProductURL = "Amazon"
        book.bookImage = "Image"
        book.bookDescription = "Description"
        book.publisher = "Publisher"
        book.buyLinks = [buyLink]
        
        let bookViewModel = BookViewModel(network: nil, favoritesManager: self.favoritesManager)
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        bookViewPresenter.addFavorite(book)

        // When
        let books = self.favoritesManager.fetchAllFavorites()
        
        // Then
        XCTAssertNotNil(books)
        XCTAssertEqual(books.count, 1)
        let retrivedBook = books[0]
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
    
    func testFetchingBookReveiwsInDelegate() throws {
        // Given
        let bookViewModel = BookViewModelStub(stubbedReviews: stubbedReviews())
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        let delegateMock = BookViewPresenterDelegateMock()
        bookViewPresenter.delegate = delegateMock

        // when
        let expectation = XCTKVOExpectation(keyPath: "review", object: delegateMock)
        bookViewPresenter.fetchBookReviews(title: "Title")
        
        self.wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertEqual(delegateMock.review, "The book is interesting")
    }
    
    func testFetchingBookReveiwsReturnsNoResultsInDelegate() throws {
        // Given
        let bookViewModel = BookViewModelStub(stubbedReviews: [])
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        let delegateMock = BookViewPresenterDelegateMock()
        bookViewPresenter.delegate = delegateMock

        // when
        let expectation = XCTKVOExpectation(keyPath: "review", object: delegateMock)
        bookViewPresenter.fetchBookReviews(title: "Title")
        
        self.wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertEqual(delegateMock.review, "No reviews")
    }
    
    func stubbedReviews() -> [Review]{
        return [Review(byLine:"ERROL MORRIS", summary:"The book is interesting")]
    }


}
