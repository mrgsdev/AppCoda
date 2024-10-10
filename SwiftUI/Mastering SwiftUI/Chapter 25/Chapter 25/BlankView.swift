//
//  BlankView.swift
//  Chapter 25
//
//  Created by mrgsdev on 10.10.2024.
//


import SwiftUI

struct BlankView : View {
    
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BlankView(bgColor: .black)
}
