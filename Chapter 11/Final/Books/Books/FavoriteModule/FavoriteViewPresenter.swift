//
//  FavoriteViewPresenter.swift
//  Books
//
//  Created by khaled mohamed el morabea on 25/06/2021.
//

import UIKit

class FavoriteViewPresenter {
    private var favoriteViewModel:FavoriteViewModel?
    
    init(favoriteViewModel:FavoriteViewModel?) {
        self.favoriteViewModel = favoriteViewModel
    }
    
    func fetchAllFavorites() -> [BookModel] {
        return self.favoriteViewModel?.fetchAllFavorites() ?? []
    }
}
