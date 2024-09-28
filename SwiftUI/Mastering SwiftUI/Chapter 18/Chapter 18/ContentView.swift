//
//  ContentView.swift
//  Chapter 18
//
//  Created by mrgsdev on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants) { restaurant in
                    BasicImageRow(restaurant: restaurant)
                        .onTapGesture {
                            self.selectedRestaurant = restaurant
                        }
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Restaurants")
        }
        .sheet(item: $selectedRestaurant) { restaurant in
            RestaurantDetailView(restaurant: restaurant)
                .ignoresSafeArea()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        }
    }
}

#Preview {
    ContentView()
}

struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

