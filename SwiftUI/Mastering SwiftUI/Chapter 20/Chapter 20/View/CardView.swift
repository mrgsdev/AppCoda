//
//  CardView.swift
//  Chapter 20
//
//  Created by mrgsdev on 29.09.2024.
//


import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        Image(card.image)
        .resizable()
        .scaledToFit()
            .overlay(
                
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
                
            , alignment: .bottomLeading)
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    
    }
}


#Preview(testCards[0].type.rawValue) {
    CardView(card: testCards[0])
}


