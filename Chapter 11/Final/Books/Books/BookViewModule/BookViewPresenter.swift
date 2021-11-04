//
//  BookViewPresenter.swift
//  Books
//
//  Created by khaled mohamed el morabea on 25/06/2021.
//

import UIKit

protocol BookViewPresenterDelegate: AnyObject {
    func reviewDidFinish(_ review: String?)
}


class BookViewPresenter {
    private var bookViewModel:BookViewModel?
    weak var delegate: BookViewPresenterDelegate?

    init(bookViewModel:BookViewModel?) {
        self.bookViewModel = bookViewModel
    }
    
    public func addFavorite(_ model: BookModel) {
        self.bookViewModel?.addFavorite(model)
    }
    
    func fetchBookReviews(title:String) {
        self.bookViewModel?.fetchBookReviews(with:title, callBack: { reviews in
            var dataTobeDisplayed:String = "No reviews"
            if let reviews = reviews, reviews.count > 0 {
                let firstReview = reviews[0]
                dataTobeDisplayed = firstReview.summary ?? "No reviews"
            }
            
            DispatchQueue.main.async {
                self.delegate?.reviewDidFinish(dataTobeDisplayed)
            }
        })
    }
}
