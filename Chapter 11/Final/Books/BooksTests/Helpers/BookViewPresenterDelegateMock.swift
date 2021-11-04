//
//  BookViewPresenterDelegateMock.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 27/06/2021.
//

import UIKit
@testable import Books

class BookViewPresenterDelegateMock:NSObject, BookViewPresenterDelegate  {
    @objc dynamic var review:String = ""
    
    func reviewDidFinish(_ review: String?) {
        self.review = review ?? ""
    }
}
