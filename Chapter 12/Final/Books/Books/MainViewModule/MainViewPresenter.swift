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
    
    public func fetchBestSellerBooks(callBack: @escaping (_ data:[List]?, _ success:Bool, _ errorMessage:String?) -> Void) {
        self.mainViewModel?.fetchBestSellerBooks(callBack: { lists in
            if let lists = lists, lists.count > 0 {
                callBack(lists, true, nil)
            } else {
                callBack([], false, "Failed to fetch best seller books")
            }
        })
    }
}
