//
//  Trip.swift
//  Chapter 30
//
//  Created by mrgsdev on 17.05.2024.
//

import UIKit
import Parse
struct Trip: Hashable {
    var tripId: String = ""
    var city: String = ""
    var country: String = ""
    var featuredImage: PFFileObject?
    var price: Int = 0
    var totalDays: Int = 0
    var isLiked: Bool = false
    
    
    init(tripId: String, city: String, country: String, featuredImage: PFFileObject!, price: Int, totalDays: Int, isLiked: Bool) {
        self.tripId = tripId
        self.city = city
        self.country = country
        self.featuredImage = featuredImage
        self.price = price
        self.totalDays = totalDays
        self.isLiked = isLiked
    }
    init(pfObject: PFObject) {
        self.tripId = pfObject.objectId!
        self.city = pfObject["city"] as! String
        self.country = pfObject["country"] as! String
        self.price = pfObject["price"] as! Int
        self.totalDays = pfObject["totalDays"] as! Int
        self.featuredImage = pfObject["featuredImage"] as? PFFileObject
        self.isLiked = pfObject["isLiked"] as! Bool
    }
    func toPFObject() -> PFObject {
        let tripObject = PFObject(className: "Trip")
        tripObject.objectId = tripId
        tripObject["city"] = city
        tripObject["country"] = country
        tripObject["featuredImage"] = featuredImage
        tripObject["price"] = price
        tripObject["totalDays"] = totalDays
        tripObject["isLiked"] = isLiked
        return tripObject
    }
    
}
