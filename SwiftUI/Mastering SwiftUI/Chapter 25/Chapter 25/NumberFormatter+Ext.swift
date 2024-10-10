//
//  NumberFormatter+Ext.swift
//  Chapter 25
//
//  Created by mrgsdev on 10.10.2024.
//


import Foundation

extension NumberFormatter {
    static func currency(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? ""
        
        return "$" + formattedValue
    }
}
