//
//  ContentView.swift
//  Chapter 36
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    let imageURL = "https://link.appcoda.com/testimage"
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                Color.purple.opacity(0.1)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.slide)
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}
