//
//  WeatherService.swift
//  Chapter 21
//
//  Created by mrgsdev on 10.05.2024.
//

import Foundation

public class WeatherService {
    public typealias WeatherDataCompletionBlock = (_ data: WeatherData?) -> ()
    
    let openWeatherBaseAPI = "https://api.openweathermap.org/data/2.5/weather?appid=5dbb5c068718ea452732e5681ceaa0c7&units=metric&q="
    let urlSession = URLSession.shared
    
    public class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    public func getCurrentWeather(location: String, completion: @escaping WeatherDataCompletionBlock) {
        
        let openWeatherAPI = openWeatherBaseAPI + location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        print(openWeatherAPI)
        
        guard let queryURL = URL(string: openWeatherAPI) else {
            return
        }
        let request = URLRequest(url: queryURL)
        var weatherData = WeatherData()
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                
                return
            }
            
            // Retrieve JSON data
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                // Parse JSON data to extract the weather condition and temperature
                
                if let weather = jsonResult?["weather"] as? [[String: Any]],
                    let weatherCondition = weather[0]["description"] as? String {
                    print(weatherCondition)
                    weatherData.weather = weatherCondition
                }
                
                if let main = jsonResult?["main"] as? [String: Any],
                    let temperature = main["temp"] as? Double {
                    weatherData.temperature = Int(temperature)
                    print("Temperature: \(weatherData.temperature)")
                }
                
                completion(weatherData)
                
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
    
}

let _sharedWeatherService: WeatherService = { WeatherService() }()
