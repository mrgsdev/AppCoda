//
//  MainView.swift
//  FoodPin
//
//  Created by mrgsdev on 03.09.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            RestaurantListView()
                .tabItem {
                    Label("Favorites", systemImage: "tag.fill")
                }
                .tag(0)
            
            Text("Discover")
                .tabItem {
                    Label("Discover", systemImage: "wand.and.rays")
                }
                .tag(1)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "square.stack")
                }
                .tag(2)
        }
        .tint(Color("NavigationBarTitle"))
    }
}

#Preview {
    MainView()
}
