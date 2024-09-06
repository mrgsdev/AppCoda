//
//  DiscoverView.swift
//  FoodPin
//
//  Created by mrgsdev on 06.09.2024.
//

import SwiftUI
import CloudKit

//struct DiscoverView: View {
//    @State private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()
//    
//    @State private var showLoadingIndicator = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                List(cloudStore.restaurants, id: \.recordID) { restaurant in
//                    VStack(alignment: .leading) {
//                        AsyncImage(url: getImageURL(restaurant: restaurant)){ image in
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        } placeholder: {
//                            Color.purple.opacity(0.1)
//                        }
//                        .frame(height: 200)
//                        .cornerRadius(30)
//                        
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(restaurant.object(forKey: "name") as! String)
//                                .font(.title2)
//                            
//                            Text(restaurant.object(forKey: "location") as! String)
//                                .font(.headline)
//                            
//                            Text(restaurant.object(forKey: "type") as! String)
//                                .font(.subheadline)
//                            
//                            Text(restaurant.object(forKey: "description") as? String ?? "")
//                                .font(.subheadline)
//                        }
//                    }
//                    
//                    .listRowSeparator(.hidden)
//                }
//                .listStyle(PlainListStyle())
//                .task {
//                    cloudStore.fetchRestaurantsWithOperational {
//                        showLoadingIndicator = false
//                    }
//                }
//                .onAppear {
//                    showLoadingIndicator = true
//                }
//                .refreshable {
//                    cloudStore.fetchRestaurantsWithOperational() {
//                        showLoadingIndicator = false
//                    }
//                }
//                
//                if showLoadingIndicator {
//                    ProgressView()
//                }
//                
//            }
//            
//            .navigationTitle("Discover")
//            .navigationBarTitleDisplayMode(.automatic)
//        }
//    }
//    
//    private func getImageURL(restaurant: CKRecord) -> URL? {
//        guard let image = restaurant.object(forKey: "image"),
//              let imageAsset = image as? CKAsset else {
//            return nil
//        }
//        
//        return imageAsset.fileURL
//    }
//}


struct DiscoverView: View {
    var body: some View  {
        Text("Discover")
    }
}
#Preview {
    DiscoverView()
}
