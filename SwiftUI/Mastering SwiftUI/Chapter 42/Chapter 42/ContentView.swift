//
//  ContentView.swift
//  Chapter 42
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    var chartView = ChartView()
   
    var body: some View {
        VStack(spacing: 20) {
            chartView
            
            HStack {
                Button {
                    let renderer = ImageRenderer(content: chartView)
                    
                    if let image = renderer.uiImage {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    }
                } label: {
                    Label("Save to Photos", systemImage: "photo")
                }
                .buttonStyle(.borderedProminent)
                
                ShareLink(item: Image(uiImage: generateSnapshot()), preview: SharePreview("Weather Chart", image: Image(uiImage: generateSnapshot())))
                .buttonStyle(.borderedProminent)
                
                Button {
                    exportPDF()
                } label: {
                    Label("PDF", systemImage: "doc.plaintext")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    @MainActor
    private func generateSnapshot() -> UIImage {
        let renderer = ImageRenderer(content: chartView)
        renderer.scale = UIScreen.main.scale
        
        return renderer.uiImage ?? UIImage()
    }
    
    @MainActor
    private func exportPDF() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let renderedUrl = documentDirectory.appending(path: "linechart.pdf")
        
        if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
           let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {
            
            let renderer = ImageRenderer(content: chartView)
            renderer.render { size, renderer in
                let options: [CFString: Any] = [
                    kCGPDFContextMediaBox: CGRect(origin: .zero, size: size)
                ]
                
                pdfContext.beginPDFPage(options as CFDictionary)
                pdfContext.translateBy(x: 0, y: 200)
                
                renderer(pdfContext)
                pdfContext.endPDFPage()
                pdfContext.closePDF()
            }
        }
      
        print("Saving PDF to \(renderedUrl.path())")
    }
}

struct ChartView: View {
    let chartData = [ (city: "Hong Kong", data: hkWeatherData),
                      (city: "London", data: londonWeatherData),
                      (city: "Taipei", data: taipeiWeatherData)
    ]
    
    var body: some View {
        VStack {
            Text("Building Line Charts in SwiftUI")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            
            Chart {
                ForEach(chartData, id: \.city) { series in
                    ForEach(series.data) { item in
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Temp", item.temperature)
                        )
                    }
                    .foregroundStyle(by: .value("City", series.city))
                    .symbol(by: .value("City", series.city))
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.defaultDigits))
                    
                }
                
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.blue.opacity(0.1))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(width: 350, height: 300)
            
            .padding(.horizontal)
            
            Text("Figure 1. Line Chart")
                .padding()
            
        }
    }
}


#Preview {
    ContentView()
}

