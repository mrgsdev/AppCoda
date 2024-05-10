//
//  WeatherData.swift
//  Chapter 21
//
//  Created by mrgsdev on 10.05.2024.
//

import Foundation

public struct WeatherData {
    
    public var temperature: Int = 0
    public var weather: String = ""
    
    public init() {}
    
    public init(temperature: Int, weather: String) {
        self.temperature = temperature
        self.weather = weather
    }
}
