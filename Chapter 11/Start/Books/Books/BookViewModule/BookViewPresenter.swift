//
//  BookViewPresenter.swift
//  Books
//
//  Created by khaled mohamed el morabea on 25/06/2021.
//

import UIKit

class BookViewPresenter {
    private var bookViewModel:BookViewModel?
    
    init(bookViewModel:BookViewModel?) {
        self.bookViewModel = bookViewModel
    }
    
    public func addFavorite(_ model: BookModel) {
        self.bookViewModel?.addFavorite(model)
    }
}
