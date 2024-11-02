//
//  DemoView.swift
//  Chapter 46
//
//  Created by mrgsdev on 20.10.2024.
//


import SwiftUI
import MapKit

struct DemoView: View {
    
    let location = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
    
//    let location = CLLocationCoordinate2D(latitude: 51.500926, longitude: -0.125977)
    
//    let location = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
     
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570), distance: 100, heading: 80, pitch: 20))
    
    var body: some View {
        Map(position: $position) {
            Annotation("Pick up", coordinate: location, anchor: .bottom) {
                Image(systemName: "car.front.waves.up")
                    .symbolEffect(.variableColor)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.indigo)
                    .clipShape(Circle())
            }
        }
        .mapStyle(.standard)
        .onAppear {
            position = .item(MKMapItem(placemark: .init(coordinate: location)))
            
                // position = .automatic
            
            position = .camera(
                MapCamera(centerCoordinate: location, distance: 800, heading: 90, pitch: 50))
        }
        
        
    }
}

#Preview {
    DemoView()
}
