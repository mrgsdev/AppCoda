//
//  ContentViewHelloWorld.swift
//  Chapter 6
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct ContentViewHelloWorld: View {
    var body: some View {
        Button {
            print("Hello World tapped!")
        } label: {
            Text("Hello World")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(.purple)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.purple, lineWidth: 5)
                }
        }
    }
}

#Preview {
    ContentViewHelloWorld()
}

