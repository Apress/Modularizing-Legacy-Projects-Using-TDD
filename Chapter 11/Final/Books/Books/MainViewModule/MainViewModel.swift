//
//  MainViewModel.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/06/2021.
//

import UIKit

class MainViewModel: NSObject {
    private var network:NetworkLayer?

    init(network:NetworkLayer?) {
        self.network = network
    }

    public func fetchBestSellerBooks(callBack: @escaping (_ lists:[List]?) -> Void) {
        self.network?.executeRequest(BooksRequest(), callBack: { data, Error in
            guard let data = data else {
                callBack(nil)
                return
            }

            var response:Response?
            do {
                response = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print(error.localizedDescription)
            }


            if let lists = response?.results.lists {
                callBack(lists)
                return;
            }

            callBack(nil)
        })
    }
}


