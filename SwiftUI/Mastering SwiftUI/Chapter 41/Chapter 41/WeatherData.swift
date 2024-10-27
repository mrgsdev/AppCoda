//
//  WeatherData.swift
//  Chapter 41
//
//  Created by mrgsdev on 20.10.2024.
//



import Foundation

struct WeatherData: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
    
    init(year: Int, month: Int, day: Int, temperature: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.temperature = temperature
    }
}

let hkWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 30.0),
                      WeatherData(year: 2021, month: 8, day: 1, temperature: 29.0),
                      WeatherData(year: 2021, month: 9, day: 1, temperature: 30.0),
                      WeatherData(year: 2021, month: 10, day: 1, temperature: 26.0),
                      WeatherData(year: 2021, month: 11, day: 1, temperature: 23.0),
                      WeatherData(year: 2021, month: 12, day: 1, temperature: 19.0),
                      WeatherData(year: 2022, month: 1, day: 1, temperature: 18.0),
                      WeatherData(year: 2022, month: 2, day: 1, temperature: 15.0),
                      WeatherData(year: 2022, month: 3, day: 1, temperature: 22.0),
                      WeatherData(year: 2022, month: 4, day: 1, temperature: 24.0),
                      WeatherData(year: 2022, month: 5, day: 1, temperature: 26.0),
                      WeatherData(year: 2022, month: 6, day: 1, temperature: 29.0)
]

let londonWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
                          WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
                          WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
                          WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
                          WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                          WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
                          WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
                          WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
                          WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
                          WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
                          WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
                          WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
]

let taipeiWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 31.0),
                          WeatherData(year: 2021, month: 8, day: 1, temperature: 30.0),
                          WeatherData(year: 2021, month: 9, day: 1, temperature: 30.0),
                          WeatherData(year: 2021, month: 10, day: 1, temperature: 26.0),
                          WeatherData(year: 2021, month: 11, day: 1, temperature: 22.0),
                          WeatherData(year: 2021, month: 12, day: 1, temperature: 19.0),
                          WeatherData(year: 2022, month: 1, day: 1, temperature: 17.0),
                          WeatherData(year: 2022, month: 2, day: 1, temperature: 17.0),
                          WeatherData(year: 2022, month: 3, day: 1, temperature: 21.0),
                          WeatherData(year: 2022, month: 4, day: 1, temperature: 23.0),
                          WeatherData(year: 2022, month: 5, day: 1, temperature: 24.0),
                          WeatherData(year: 2022, month: 6, day: 1, temperature: 27.0)
]
