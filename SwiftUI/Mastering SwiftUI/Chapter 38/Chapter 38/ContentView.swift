//
//  ContentView.swift
//  Chapter 38
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    let weekdays = Calendar.current.shortWeekdaySymbols
    let steps = [ 10531, 6019, 7200, 8311, 7403, 6503, 9230 ]
    
    var body: some View {
        Chart {
            ForEach(weekdays.indices, id: \.self) { index in
                BarMark(
                    x: .value("Steps", steps[index]),
                    y: .value("Day", weekdays[index])
                )
                .foregroundStyle(by: .value("Day", weekdays[index]))
                .annotation {
                    Text("\(steps[index])")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
