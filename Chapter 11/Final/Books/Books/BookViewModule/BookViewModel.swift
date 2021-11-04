//
//  BookViewModel.swift
//  Books
//
//  Created by khaled mohamed el morabea on 26/06/2021.
//

import UIKit

class BookViewModel: NSObject {
    private var network:NetworkLayer?
    private var favoritesManager:FavoritesManager?

    init(network:NetworkLayer?, favoritesManager:FavoritesManager?) {
        self.network = network
        self.favoritesManager = favoritesManager
    }
    
    public func addFavorite(_ model: BookModel) {
        self.favoritesManager?.addFavorite(model)
    }

    public func fetchBookReviews(with title:String, callBack: @escaping (_ reviews:[Review]?) -> Void) {        self.network?.executeRequest(ReviewsRequest(title: title), callBack: { data, Error in
            guard let data = data else {
                callBack(nil)
                return
            }

            var response:ReviewsResponse?
            do {
                response = try JSONDecoder().decode(ReviewsResponse.self, from: data)
            } catch {
                print(error.localizedDescription)
            }


            if let reviews = response?.results {
                callBack(reviews)
                return;
            }

            callBack(nil)
        })
    }
}
