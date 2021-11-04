//
//  AuthorResponse.swift
//  Books
//
//  Created by khaled mohamed el morabea on 13/05/2021.
//

import Foundation

// MARK: - Welcome
struct AuthorResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Author]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct Author: Codable {
    let url: String
    let publicationDt, byline, bookTitle, bookAuthor: String
    let summary: String

    enum CodingKeys: String, CodingKey {
        case url
        case publicationDt = "publication_dt"
        case byline
        case bookTitle = "book_title"
        case bookAuthor = "book_author"
        case summary
    }
}
