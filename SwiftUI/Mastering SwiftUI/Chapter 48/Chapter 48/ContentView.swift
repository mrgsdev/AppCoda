//
//  ContentView.swift
//  Chapter 48
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    enum ChartType: String, CaseIterable, Identifiable {
        var id: Self { return self }
        
        case pie = "Pie Chart"
        case donut = "Donut Chart"
    }
    
    private var coffeeSales = [
        (name: "Americano", count: 120),
        (name: "Cappuccino", count: 234),
        (name: "Espresso", count: 62),
        (name: "Latte", count: 625),
        (name: "Mocha", count: 320),
        (name: "Affogato", count: 50)
    ]
    
    @State private var chartType: ChartType = .donut
    @State private var selectedAngle: Double?
    @State private var selectedSegment: String?
    
    var body: some View {
        
        VStack {
            
            Picker("Test", selection: $chartType) {
                
                ForEach(ChartType.allCases) { chart in
                    Text(chart.rawValue)
                        .tag(chart)
                }
                
            }
            .pickerStyle(.segmented)
            
            Chart {
                ForEach(coffeeSales, id: \.name) { element in
                    SectorMark(angle: .value("Count", element.count), innerRadius: .ratio(chartType == .donut ? 0.65 : 0),
                               outerRadius: .inset(20),
                               angularInset: chartType == .donut ? 3 : 0)
                    .cornerRadius(chartType == .donut ? 5 : 0)
                    .foregroundStyle(by: .value("Coffee Type", element.name))
                    .annotation(position: .overlay) {
                        Text("\(element.count)")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    .opacity(selectedSegment == nil ? 1.0 : (selectedSegment == element.name ? 1.0 : 0.5))
                    
                }
            }
            .animation(.default, value: chartType)
            .chartBackground(alignment: .top) { proxy in
                Text("Sales for the last 30 days")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .padding(.top)
            }
            .chartAngleSelection(value: $selectedAngle)
            .onChange(of: selectedAngle) { oldValue, newValue in
                if let newValue {
                    findSelectedSegment(value: newValue)
                } else {
                    selectedSegment = nil
                }
            }
            
        }
        .padding()
    }
    
    private func findSelectedSegment(value: Double) {
    
        var accumulatedCount = 0
        
        let coffee = coffeeSales.first { (_, count) in
            accumulatedCount += count
            return value <= Double(accumulatedCount)
        }
        
        selectedSegment = coffee?.name
    }
}

#Preview {
    ContentView()
}
