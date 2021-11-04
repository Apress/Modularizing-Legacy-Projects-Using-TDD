//
//  ListModel.swift
//  Books
//
//  Created by khaled mohamed el morabea on 13/05/2021.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let status, copyright: String
    let numResults: Int
    let results: Results

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Results
struct Results: Codable {
    let bestsellersDate, publishedDate, publishedDateDescription, previousPublishedDate: String
    let nextPublishedDate: String
    let lists: [List]

    enum CodingKeys: String, CodingKey {
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case previousPublishedDate = "previous_published_date"
        case nextPublishedDate = "next_published_date"
        case lists
    }
}

// MARK: - List
struct List: Codable, Equatable {
    var listID: Int
    var listName, displayName: String
    var books: [BookModel]

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case listName = "list_name"
        case displayName = "display_name"
        case books
    }
    
    static func == (lhs: List, rhs: List) -> Bool {
        lhs.listID == rhs.listID &&
        lhs.listName == rhs.listName &&
        lhs.displayName == rhs.displayName &&
        lhs.books == rhs.books
    }
}

// MARK: - BuyLink
struct BuyLinkModel: Codable {
    var name: Name
    var url: String
    
    init(name:Name, url:String) {
        self.name = name
        self.url = url
    }
    
    enum Name: String, Codable {
        case amazon = "Amazon"
        case appleBooks = "Apple Books"
        case barnesAndNoble = "Barnes and Noble"
        case booksAMillion = "Books-A-Million"
        case bookshop = "Bookshop"
        case indieBound = "IndieBound"
    }
}


// MARK: - Book
struct BookModel: Codable, Equatable {
    
    var ageGroup: String?
    var amazonProductURL: String?
    var articleChapterLink, author: String?
    var bookImage: String?
    var bookImageWidth, bookImageHeight: Int?
    var bookReviewLink: String?
    var contributor: String?
    var createdDate, bookDescription, firstChapterLink, price: String?
    var primaryIsbn10, primaryIsbn13, bookURI, publisher: String?
    var rank, rankLastWeek: Int?
    var sundayReviewLink: String?
    var title, updatedDate: String?
    var weeksOnList: Int?
    var buyLinks: [BuyLinkModel]?
    
    init(title:String, contributor:String, author:String, createdDate:String) {
        self.title = title
        self.contributor = contributor
        self.author = author
        self.createdDate = createdDate
    }

    enum CodingKeys: String, CodingKey {
        case ageGroup = "age_group"
        case amazonProductURL = "amazon_product_url"
        case articleChapterLink = "article_chapter_link"
        case author
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case bookReviewLink = "book_review_link"
        case contributor
        case createdDate = "created_date"
        case bookDescription = "description"
        case firstChapterLink = "first_chapter_link"
        case price
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case bookURI = "book_uri"
        case publisher, rank
        case rankLastWeek = "rank_last_week"
        case sundayReviewLink = "sunday_review_link"
        case title
        case updatedDate = "updated_date"
        case weeksOnList = "weeks_on_list"
        case buyLinks = "buy_links"
    }
    
    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.contributor == rhs.contributor &&
        lhs.author == rhs.author &&
        lhs.createdDate == rhs.createdDate
    }
}


// MARK: - ReviewsResponse
struct ReviewsResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Review]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Review
struct Review: Codable, Equatable {
    var byLine: String?
    var summary: String?
    
    
    init(byLine:String, summary:String) {
        self.byLine = byLine
        self.summary = summary
    }

    enum CodingKeys: String, CodingKey {
        case byLine = "byline"
        case summary = "summary"
    }
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        lhs.byLine == rhs.byLine &&
        lhs.summary == rhs.summary
    }
}
