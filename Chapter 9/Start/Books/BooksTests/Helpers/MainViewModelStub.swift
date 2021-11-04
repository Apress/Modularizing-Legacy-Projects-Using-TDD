//
//  MainViewModelStub.swift
//  BooksTests
//
//  Created by khaled mohamed el morabea on 02/06/2021.
//

import UIKit
@testable import Books

class MainViewModelStub: MainViewModel {
    var stubbedLists:[List]?
    
    init(stubbedLists:[List]) {
        self.stubbedLists = stubbedLists
        super.init(networkLayer: nil)
    }
    
    public override func fetchBestSellerBooks(callBack: @escaping (_ lists:[List]?) -> Void) {
        callBack(self.stubbedLists)
    }
}
