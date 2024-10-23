//
//  SimpleLineChartView.swift
//  Chapter 38
//
//  Created by mrgsdev on 20.10.2024.
//


import SwiftUI
import Charts

struct SimpleLineChartView: View {
    
    let chartData = [ (city: "Hong Kong", data: hkWeatherData),
                      (city: "London", data: londonWeatherData),
                      (city: "Taipei", data: taipeiWeatherData) ]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(chartData, id: \.city) { series in
                    ForEach(series.data) { item in
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Temp", item.temperature)
                        )
                        .interpolationMethod(.stepStart)
                    }
                    .foregroundStyle(by: .value("City", series.city))
                    .symbol(by: .value("City", series.city))
                }
            }
            .frame(height: 300)
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.defaultDigits))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.blue.opacity(0.1))
            }
        }
    }
}

#Preview {
    SimpleLineChartView()
}
