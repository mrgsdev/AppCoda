//
//  Weather_Widget.swift
//  Weather Widget
//
//  Created by mrgsdev on 10.05.2024.
//

import WidgetKit
import SwiftUI
import WeatherInfoKit

struct Provider: TimelineProvider {
    var defaults = UserDefaults(suiteName: "group.com.mrgsdev.chapter21")!
    
    func placeholder(in context: Context) -> WeatherEntry {
        let weatherData = WeatherData(temperature: 0, weather: "--")
        return WeatherEntry(date: Date(), weatherData: weatherData)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        
        let weatherData = WeatherData(temperature: 30, weather: "Sunny")
        let entry = WeatherEntry(date: Date(), weatherData: weatherData)

        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // The widget is scheduled to update every hour.
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        
        // Get the location from defaults
        guard let city = defaults.value(forKey: "city") as? String else {
            return
        }
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: city) { (data) in
            
            guard let weatherData = data else {
                return
            }
            
            let entry = WeatherEntry(date: currentDate, city: city, weatherData: weatherData)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            
            completion(timeline)
            
        }

    }
}

struct WeatherEntry: TimelineEntry {
    var date: Date
    var city: String = "paris"
    var weatherData: WeatherData
}

struct Weather_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.city.capitalized)
                .font(.system(size: 16, weight: .black, design: .rounded))
                .padding(.bottom, 2)
            Text(entry.weatherData.weather.capitalized)
                .font(.footnote)
                .padding(.bottom, 2)
            Text("\(entry.weatherData.temperature)℃")
                .font(.system(size: 20, weight: .black, design: .rounded))
            Text(entry.date, style: .time)
                .font(.footnote)
                .padding(.top, 10)
        }
    }
}

struct Weather_Widget: Widget {
    let kind: String = "Weather_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Weather_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This widget is designed to display the current weather information.")
    }
}

struct Weather_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Weather_WidgetEntryView(entry: WeatherEntry(date: Date(), weatherData: WeatherData(temperature: 10, weather: "Cloudy")))
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
