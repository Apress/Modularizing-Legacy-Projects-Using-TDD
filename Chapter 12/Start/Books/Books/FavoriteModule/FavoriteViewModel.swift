//
//  FavoriteViewModel.swift
//  Books
//
//  Created by khaled mohamed el morabea on 25/06/2021.
//

import UIKit

class FavoriteViewModel: NSObject {
    private var favoritesManager:FavoritesManager?

    init(favoritesManager:FavoritesManager?) {
        self.favoritesManager = favoritesManager
    }

    public func fetchAllFavorites() -> [BookModel] {
        self.favoritesManager?.fetchAllFavorites().map({ book in
            book.convertToBookModel()
        }) ?? []
    }
}
