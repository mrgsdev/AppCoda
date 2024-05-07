//
//  Icon.swift
//  Chapter 19
//
//  Created by mrgsdev on 05.05.2024.
//

import Foundation

struct Icon: Hashable {
    var name: String = ""
    var imageName = ""
    var description = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, imageName: String, description: String, price: Double, isFeatured: Bool) {
        self.name = name
        self.imageName = imageName
        self.description = description
        self.price = price
        self.isFeatured = isFeatured
    }
}
