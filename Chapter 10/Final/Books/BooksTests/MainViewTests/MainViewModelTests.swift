//
//  MainViewModelTests.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 02/06/2021.
//

import XCTest
@testable import Books

class MainViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingAndParsingBestSellerBooks() throws {
        // Given
        let testBundle = Bundle(for: type(of: self))
        let booksJSONURL = testBundle.url(forResource: "BestSellerBooksStub", withExtension: "json")
        let booksJSON = try Data(contentsOf: booksJSONURL!)

        let expectedLists: [List] = stubbedlists()
        var actualLists: [List] = []

        let network = NetworkLayerStub(stubbedData: booksJSON)
        let mainViewModel = MainViewModel(network: network)
        
        // when & then
        let waitForBooks = XCTestExpectation(description: "Wait to fetch books")
        mainViewModel.fetchBestSellerBooks { lists in
            actualLists = lists ?? []
            waitForBooks.fulfill()
        }
        
        self.wait(for: [waitForBooks], timeout: 0.1)
        XCTAssertEqual(actualLists, expectedLists, "Fetched books does not match the expected")
    }
    
    func stubbedlists() -> [List] {
        var firstBook = BookModel(title: "THE LAST THING HE TOLD ME", contributor: "by Laura Dave", author: "Laura Dave", createdDate: "2021-05-26 22:10:24")
        firstBook.amazonProductURL = "https://www.amazon.com/dp/1501171348?tag=NYTBSREV-20"
        firstBook.bookImage = "https://storage.googleapis.com/du-prd/books/images/9781501171345.jpg"
        firstBook.bookDescription = "Hannah Hall discovers truths about her missing husband and bonds with his daughter from a previous relationship."
        firstBook.publisher = "Simon & Schuster"
        firstBook.buyLinks = getBuyLinks1()

        var secondBook = BookModel(title: "SOOLEY", contributor: "by John Grisham", author: "John Grisham", createdDate: "2021-05-26 22:10:24")
        secondBook.amazonProductURL = "https://www.amazon.com/dp/0385547684?tag=NYTBSREV-20"
        secondBook.bookImage = "https://storage.googleapis.com/du-prd/books/images/9780385547680.jpg"
        secondBook.bookDescription = "Samuel Sooleymon receives a basketball scholarship to North Carolina Central and determines to bring his family over from a civil war-ravaged South Sudan."
        secondBook.publisher = "Doubleday"
        secondBook.buyLinks = getBuyLinks2()
        
        let firstList = List(listID: 704, listName: "Combined Print and E-Book Fiction", displayName: "Combined Print & E-Book Fiction", books: [firstBook,secondBook])
        return [firstList]
    }
    
    func getBuyLinks1() -> [BuyLinkModel] {
        let amazonBuyLink1 = BuyLinkModel(name: .amazon, url: "https://www.amazon.com/dp/1501171348?tag=NYTBSREV-20")
        let appleBuyLink1 = BuyLinkModel(name: .appleBooks, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=THE+LAST+THING+HE+TOLD+ME&author=Laura+Dave")
        let barnesAndNobleBuyLink1 = BuyLinkModel(name: .barnesAndNoble, url: "https://www.anrdoezrs.net/click-7990613-11819508?url=https%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9781501171369")
        let booksAMillionBuyLink1 = BuyLinkModel(name: .booksAMillion, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fp%252FTHE%252BLAST%252BTHING%252BHE%252BTOLD%252BME%252FLaura%252BDave%252F9781501171369&url2=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fsearch%253Fquery%253DTHE%252BLAST%252BTHING%252BHE%252BTOLD%252BME%252BLaura%252BDave")
        let bookshopBuyLink1 = BuyLinkModel(name: .bookshop, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fbookshop.org%2Fa%2F3546%2F9781501171369&url2=https%3A%2F%2Fbookshop.org%2Fbooks%3Fkeywords%3DTHE%2BLAST%2BTHING%2BHE%2BTOLD%2BME")
        let indieBoundBuyLink1 = BuyLinkModel(name: .indieBound, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.indiebound.org%2Fbook%2F9781501171369%3Faff%3DNYT&url2=https%3A%2F%2Fwww.indiebound.org%2Fsearch%2Fbook%3Fkeys%3DTHE%2BLAST%2BTHING%2BHE%2BTOLD%2BME%2BLaura%2BDave%26aff%3DNYT")

        return [amazonBuyLink1, appleBuyLink1, barnesAndNobleBuyLink1, booksAMillionBuyLink1, bookshopBuyLink1,indieBoundBuyLink1]
    }
        
    func getBuyLinks2() -> [BuyLinkModel] {
        let amazonBuyLink1 = BuyLinkModel(name: .amazon, url: "https://www.amazon.com/dp/0385547684?tag=NYTBSREV-20")
        let appleBuyLink1 = BuyLinkModel(name: .appleBooks, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=SOOLEY&author=John+Grisham")
        let barnesAndNobleBuyLink1 = BuyLinkModel(name: .barnesAndNoble, url: "https://www.anrdoezrs.net/click-7990613-11819508?url=https%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9780385547680")
        let booksAMillionBuyLink1 = BuyLinkModel(name: .booksAMillion, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fp%252FSOOLEY%252FJohn%252BGrisham%252F9780385547680&url2=https%3A%2F%2Fwww.anrdoezrs.net%2Fclick-7990613-35140%3Furl%3Dhttps%253A%252F%252Fwww.booksamillion.com%252Fsearch%253Fquery%253DSOOLEY%252BJohn%252BGrisham")
        let bookshopBuyLink1 = BuyLinkModel(name: .bookshop, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fbookshop.org%2Fa%2F3546%2F9780385547680&url2=https%3A%2F%2Fbookshop.org%2Fbooks%3Fkeywords%3DSOOLEY")
        let indieBoundBuyLink1 = BuyLinkModel(name: .indieBound, url: "https://du-gae-books-dot-nyt-du-prd.appspot.com/redirect?url1=https%3A%2F%2Fwww.indiebound.org%2Fbook%2F9780385547680%3Faff%3DNYT&url2=https%3A%2F%2Fwww.indiebound.org%2Fsearch%2Fbook%3Fkeys%3DSOOLEY%2BJohn%2BGrisham%26aff%3DNYT")
        
        return [amazonBuyLink1, appleBuyLink1, barnesAndNobleBuyLink1, booksAMillionBuyLink1, bookshopBuyLink1, indieBoundBuyLink1]
    }
}
