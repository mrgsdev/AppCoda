//
//  Trip.swift
//  Chapter 29
//
//  Created by mrgsdev on 16.05.2024.
//

import UIKit

struct Trip: Hashable {
    var tripId: String = ""
    var city: String = ""
    var country: String = ""
    var featuredImage: UIImage?
    var price: Int = 0
    var totalDays: Int = 0
    var isLiked: Bool = false
}
