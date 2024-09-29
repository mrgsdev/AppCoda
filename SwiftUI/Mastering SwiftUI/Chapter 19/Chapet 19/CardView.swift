//
//  CardView.swift
//  Chapet 19
//
//  Created by mrgsdev on 29.09.2024.
//


import SwiftUI

struct CardView: View, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(alignment: .bottom) {
                VStack {
                    
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(.white)
                        .cornerRadius(5)
                }
                .padding([.bottom], 20)
            }
    }
}

#Preview {
    CardView(image: "yosemite-usa", title: "Yosemite, USA")
}
