//
//  BookViewModelStub.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import UIKit
@testable import Books

class BookViewModelStub: BookViewModel {
    var stubbedReviews:[Review]?
    
    init(stubbedReviews:[Review]) {
        self.stubbedReviews = stubbedReviews
        super.init(network: nil, favoritesManager: nil)
    }
    
    override public func fetchBookReviews(with title:String, callBack: @escaping (_ reviews:[Review]?) -> Void) {
        callBack(self.stubbedReviews!)
    }
}
