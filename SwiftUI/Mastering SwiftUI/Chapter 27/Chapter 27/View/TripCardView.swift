//
//  TripCardView.swift
//  Chapter 27
//
//  Created by mrgsdev on 12.10.2024.
//


import SwiftUI

struct TripCardView: View {
    let destination: String
    let imageName: String
    
    @Binding var isShowDetails: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(self.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(self.isShowDetails ? 0 : 15)
                    .overlay(
                        Text(self.destination)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(10)
                            .background(Color.white)
                            .padding([.bottom, .leading])
                            .opacity(self.isShowDetails ? 0.0 : 1.0)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                    )
            }
            
        }
    }
}



#Preview {
    TripCardView(destination: "London", imageName: "london", isShowDetails: .constant(false))
}
