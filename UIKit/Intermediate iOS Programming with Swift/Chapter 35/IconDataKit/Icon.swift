//
//  Icon.swift
//  Chapter 35
//
//  Created by mrgsdev on 22.05.2024.
//

import Foundation
import Messages

public struct Icon: Hashable {
    public var name: String = ""
    public var imageName = ""
    public var description = ""
    public var price: Double = 0.0
    public var isFeatured: Bool = false
    
    init(name: String, imageName: String, description: String, price: Double, isFeatured: Bool) {
        self.name = name
        self.imageName = imageName
        self.description = description
        self.price = price
        self.isFeatured = isFeatured
    }
}

public extension Icon {
    
    enum QueryItemKey: String {
        case name = "name"
        case imageName = "imageName"
        case description = "description"
        case price = "price"
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: QueryItemKey.name.rawValue, value: name))
        items.append(URLQueryItem(name: QueryItemKey.imageName.rawValue, value: imageName))
        items.append(URLQueryItem(name: QueryItemKey.description.rawValue, value: description))
        items.append(URLQueryItem(name: QueryItemKey.price.rawValue, value: String(price)))
        
        return items
    }
    
    init(queryItems: [URLQueryItem]) {
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
            if queryItem.name == QueryItemKey.name.rawValue {
                self.name = value
            }
            
            if queryItem.name == QueryItemKey.imageName.rawValue {
                self.imageName = value
            }
            
            if queryItem.name == QueryItemKey.description.rawValue {
                self.description = value
            }
            
            if queryItem.name == QueryItemKey.price.rawValue {
                self.price = Double(value) ?? 0.0
            }
        }
    }
}

public extension Icon {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        
        guard let urlComponents = URLComponents(url: messageURL, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
                return nil
        }
        
        self.init(queryItems: queryItems)
    }
}
