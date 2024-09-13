//
//  PricingView.swift
//  Chapter 4
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct PricingView: View {
    
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?
    
    var body: some View {
        VStack {
            
            if let icon = icon {
                
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
                
            }
            
            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}


#Preview {
    PricingView(
        title: "Basic",
        price: "$9",
        textColor: .white,
        bgColor: .purple
    )
}
