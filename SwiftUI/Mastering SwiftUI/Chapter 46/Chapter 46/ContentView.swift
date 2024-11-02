//
//  ContentView.swift
//  Chapter 46
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let bigBen = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
    
    static let towerBridge = CLLocationCoordinate2D(latitude: 51.505507, longitude: -0.075402)
    
    static let pickupLocation = CLLocationCoordinate2D(latitude: 51.500926, longitude: -0.125977)
}

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        Map(position: $position) {
            Annotation("Pick up", coordinate: .pickupLocation, anchor: .bottom) {
                ZStack {
                    Circle()
                        .foregroundStyle(.indigo.opacity(0.5))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "car.front.waves.up")
                        .symbolEffect(.variableColor)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.indigo)
                        .clipShape(Circle())
                }
            }
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
            .onAppear {
                position = .camera(
                    MapCamera(centerCoordinate: .bigBen, distance: 800, heading: 90, pitch: 50))
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Button(action: {
                        withAnimation {
                            position = .camera(
                                MapCamera(centerCoordinate: .bigBen, distance: 2000, heading: 90, pitch: 50))
                            
                            search(location: .bigBen, query: "restaurants")
                        }
                    }) {
                        Text("Big Ben")
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        withAnimation {
                            position = .camera(
                                MapCamera(centerCoordinate: .towerBridge, distance: 2000, heading: 90, pitch: 50))
                            
                            search(location: .towerBridge, query: "restaurants")
                        }
                        
                    }) {
                        Text("Tower Bridge")
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                }
            }
    }
    
    private func search(location: CLLocationCoordinate2D, query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
                            center: location,
                            latitudinalMeters: 100,
                            longitudinalMeters: 100)
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    ContentView()
}
