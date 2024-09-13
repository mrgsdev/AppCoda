//
//  ExerciseView.swift
//  Chapter 4
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct ExerciseView: View {
    var body: some View {
        ZStack {
            
            PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple, icon: "burst.fill")
                .padding()
                .offset(x: 0, y: 180)
                
            PricingView(title: "Pro", price: "$19", textColor: .white, bgColor: Color(red: 255/255, green: 183/255, blue: 37/255), icon: "dial")
                .padding()
                .scaleEffect(0.95)
            
            PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                .padding()
                .scaleEffect(0.9)
                .offset(x: 0, y: -180)
        }
    }
}




#Preview {
    ExerciseView()
}
