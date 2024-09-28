//
//  RestaurantDetailView.swift
//  Chapter 18
//
//  Created by mrgsdev on 28.09.2024.
//


import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack {
            Spacer()
            
            HandleBar()
          
            ScrollView(.vertical) {
                TitleBar()
                
                HeaderView(restaurant: self.restaurant)
                
                DetailInfoView(icon: "map", info: self.restaurant.location)
                    .padding(.top)
                DetailInfoView(icon: "phone", info: self.restaurant.phone)
                DetailInfoView(icon: nil, info: self.restaurant.description)
                    .padding(.top);
            }
            .background(.white)
            .cornerRadius(10, antialiased: true)
        }
    }
}

#Preview {
    RestaurantDetailView(restaurant: restaurants[0])
}


struct HandleBar: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundStyle(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct TitleBar: View {
    
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding()
    }
}

struct HeaderView: View {
    let restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(restaurant.name)
                            .foregroundStyle(.white)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                        
                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                        
                    }
                    Spacer()
                }
                .padding()
            )
    }
}

struct DetailInfoView: View {
    let icon: String?
    let info: String
    
    var body: some View  {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            
            Spacer()
        }.padding(.horizontal)
    }
}
