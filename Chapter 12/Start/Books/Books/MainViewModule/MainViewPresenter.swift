//
//  MainViewPresenter.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/06/2021.
//

import UIKit

class MainViewPresenter: NSObject {
    
    private var mainViewModel:MainViewModel?
    
    init(mainViewModel:MainViewModel?) {
        self.mainViewModel = mainViewModel
    }
    
    public func fetchBestSellerBooks(callBack: @escaping (_ data:[List]?) -> Void) {
        self.mainViewModel?.fetchBestSellerBooks(callBack: { lists in
            callBack(lists)
        })
    }
}
