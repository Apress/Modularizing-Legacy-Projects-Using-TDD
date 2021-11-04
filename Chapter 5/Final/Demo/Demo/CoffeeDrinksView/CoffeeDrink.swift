//
//  CoffeeDrink.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit

struct CoffeeDrink: Codable, Equatable {
    let name:String?
    let imageName: String?
    let description: String?

    private enum CodingKeys : String, CodingKey {
        case name = "name"
        case imageName = "image_name"
        case description = "desc"
    }
}
