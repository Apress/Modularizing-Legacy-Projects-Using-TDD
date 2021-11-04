//
//  BookViewModel.swift
//  Books
//
//  Created by khaled mohamed el morabea on 25/06/2021.
//

import UIKit

class BookViewModel {
    private var favoritesManager:FavoritesManager?

    init(favoritesManager:FavoritesManager?) {
        self.favoritesManager = favoritesManager
    }

    public func addFavorite(_ model: BookModel) {
        self.favoritesManager?.addFavorite(model)
    }
}
