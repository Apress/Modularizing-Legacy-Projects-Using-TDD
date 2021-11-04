//
//  BookViewIntegrationTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import XCTest
@testable import Books

class BookViewIntegrationTests: XCTestCase {

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

    func testFetchingBooksReturnsAReviewInPresenterDelegate() {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let booksReveiwsJSONURL = testBundle.url(forResource: "booksReview", withExtension: "json")
        let booksReveiwsJSON = try! Data(contentsOf: booksReveiwsJSONURL!)
        let networkLayer = NetworkLayerStub(stubbedData: booksReveiwsJSON)
        
        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: self.favoritesManager)
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        let delegateMock = BookViewPresenterDelegateMock()
        bookViewPresenter.delegate = delegateMock

        // when
        let expectation = XCTKVOExpectation(keyPath: "review", object: delegateMock)
        bookViewPresenter.fetchBookReviews(title: "THE LAST THING HE TOLD ME")

        self.wait(for: [expectation], timeout: 0.1)

        
        // Then
        XCTAssertTrue(delegateMock.review == "The book is interesting", "Fetched fetch and view expected reviews")
    }
    
    func stubbedReviews() -> [Review]{
        return [Review(byLine:"ERROL MORRIS", summary:"The book is interesting")]
    }

    
    func testSavingAndViewingBook() throws {
        // Given
        let book = self.getBookWith(index: 0)
        let networkLayer = NetworkLayer()

        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: self.favoritesManager)
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)

        // When
        bookViewPresenter.addFavorite(book)

        let favoriteViewModel = FavoriteViewModel(favoritesManager: self.favoritesManager)
        let favViewPresenter = FavoriteViewPresenter(favoriteViewModel: favoriteViewModel)


        // Then
        let books = favViewPresenter.fetchAllFavorites()
        XCTAssertNotNil(books)
        XCTAssertEqual(books.count, 1)
        let retrivedBook = books[0]
        XCTAssertEqual(retrivedBook, book)
    }
    
    func testSavingAndViewingMultipleBooks() throws {
        // Given
        let book1 = self.getBookWith(index: 0)
        let book2 = self.getBookWith(index: 1)
        let networkLayer = NetworkLayer()


        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: self.favoritesManager)
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        
        // When
        bookViewPresenter.addFavorite(book1)
        bookViewPresenter.addFavorite(book2)

        let favoriteViewModel = FavoriteViewModel(favoritesManager: self.favoritesManager)
        let favViewPresenter = FavoriteViewPresenter(favoriteViewModel: favoriteViewModel)

        
        // Then
        let books = favViewPresenter.fetchAllFavorites()
        XCTAssertNotNil(books)
        XCTAssertEqual(books.count, 2)
        let retrivedBook1 = books[0]
        let retrivedBook2 = books[1]
        
        XCTAssertEqual(retrivedBook1, book1)
        XCTAssertEqual(retrivedBook2, book2)
    }
    
    func testSavingDeletingAndViewingMultipleBooks() throws {
        // Given
        let book1 = self.getBookWith(index: 0)
        let book2 = self.getBookWith(index: 1)
        let book3 = self.getBookWith(index: 2)
        let networkLayer = NetworkLayer()

        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: self.favoritesManager)
        let bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)
        
        // When
        bookViewPresenter.addFavorite(book1)
        bookViewPresenter.addFavorite(book2)
        bookViewPresenter.addFavorite(book3)
        
        let favoriteViewModel = FavoriteViewModel(favoritesManager: self.favoritesManager)
        let favViewPresenter = FavoriteViewPresenter(favoriteViewModel: favoriteViewModel)
        self.favoritesManager.deleteFavorite(book2)
        
        
        // Then
        let books = favViewPresenter.fetchAllFavorites()
        XCTAssertNotNil(books)
        XCTAssertEqual(books.count, 2)
        let retrivedBook1 = books[0]
        let retrivedBook3 = books[1]
        
        XCTAssertEqual(retrivedBook1, book1)
        XCTAssertEqual(retrivedBook3, book3)
    }
    
    func assertOn(retrivedBook:Book, book:BookModel)  {
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
        XCTAssertEqual(link?.name, book.buyLinks![0].name.rawValue)
        XCTAssertEqual(link?.url, book.buyLinks![0].url)
    }
    
    func getBookWith(index: Int) -> BookModel {
        let buyLink = BuyLinkModel(name: .amazon, url: "URL")
        var book = BookModel(title: "BookTitle\(index)", contributor: "Contributor\(index)", author: "Author\(index)", createdDate: "2021-05-26 22:10:24")
        book.amazonProductURL = "Amazon\(index)"
        book.bookImage = "Image\(index)"
        book.bookDescription = "Description\(index)"
        book.publisher = "Publisher\(index)"
        book.buyLinks = [buyLink]
        
        return book
    }
}
