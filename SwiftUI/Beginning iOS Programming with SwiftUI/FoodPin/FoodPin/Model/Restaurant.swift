//
//  Restaurant.swift
//  FoodPin
//
//  Created by mrgsdev on 24.08.2024.
//

import Foundation
struct Restaurant {
    var name: String
    var type: String
    var location: String
    var image: String
    var isFavorite: Bool
    
    init(name: String, type: String, location: String, image: String, isFavorite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
    }
    
    init() {
        self.init(
            name: "",
            type: "",
            location: "",
            image: "",
            isFavorite:
                false
        )
    }
}
