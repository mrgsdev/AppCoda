//
//  Icon.swift
//  Chapter 18
//
//  Created by mrgsdev on 04.05.2024.
//

import Foundation

struct Icon: Hashable {
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, price: Double, isFeatured: Bool) {
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
    }
}
