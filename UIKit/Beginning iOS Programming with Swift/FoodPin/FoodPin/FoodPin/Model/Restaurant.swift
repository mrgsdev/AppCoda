//
//  Restaurant.swift
//  FoodPin
//
//  Created by mrgsdev on 11.04.2024.
//

import Foundation
struct Restaurant: Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var description: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}
