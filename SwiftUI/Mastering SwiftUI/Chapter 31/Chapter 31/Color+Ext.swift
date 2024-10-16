//
//  Color+Ext.swift
//  Chapter 31
//
//  Created by mrgsdev on 14.10.2024.
//


import SwiftUI

extension Color {
    
    public init(red: Int, green: Int, blue: Int, opacity: Double = 1.0) {
        let redValue = Double(red) / 255.0
        let greenValue = Double(green) / 255.0
        let blueValue = Double(blue) / 255.0
        
        self.init(red: redValue, green: greenValue, blue: blueValue, opacity: opacity)
    }

    public static let lightRed = Color(red: 231, green: 76, blue: 60)
    public static let darkRed = Color(red: 192, green: 57, blue: 43)
    public static let lightGreen = Color(red: 46, green: 204, blue: 113)
    public static let darkGreen = Color(red: 39, green: 174, blue: 96)
    public static let lightPurple = Color(red: 155, green: 89, blue: 182)
    public static let darkPurple = Color(red: 142, green: 68, blue: 173)
    public static let lightBlue = Color(red: 52, green: 152, blue: 219)
    public static let darkBlue = Color(red: 41, green: 128, blue: 185)
    public static let lightYellow = Color(red: 241, green: 196, blue: 15)
    public static let darkYellow = Color(red: 243, green: 156, blue: 18)
    public static let lightOrange = Color(red: 230, green: 126, blue: 34)
    public static let darkOrange = Color(red: 211, green: 84, blue: 0)
    public static let purpleBg = Color(red: 69, green: 51, blue: 201)
}
