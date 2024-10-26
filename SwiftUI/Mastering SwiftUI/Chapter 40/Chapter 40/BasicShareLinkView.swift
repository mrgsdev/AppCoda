//
//  BasicShareLinkView.swift
//  Chapter 40
//
//  Created by mrgsdev on 20.10.2024.
//


import SwiftUI

struct BasicShareLinkView: View {
    private let url = URL(string: "https://www.appcoda.com")!

    var body: some View {
        ShareLink(item: url) {
            Label("Tap me to share", systemImage:  "square.and.arrow.up")
        }
    }
}

struct ImageShareLinkView: View {
    private let photo = Image("bigben")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            photo
                .resizable()
                .scaledToFit()
            
            ShareLink(item: Image("bigben"), preview: SharePreview("Big Ben", image: photo))

        }
        .padding(.horizontal)
    }
}

struct ContentView: View {
    private let photo = Image("bigben")
    
    var body: some View {
        TabView {
            ForEach(photos) { photo in
                VStack(alignment: .leading, spacing: 10) {
                    photo.image
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Text(photo.caption)
                            .font(.headline)
                        
                        ShareLink(item: photo, preview: SharePreview(photo.caption, image: photo.image))
                    }
                    
                    Text(photo.description)
                }
                .padding(.horizontal)
            }
            
        }
        .tabViewStyle(.page)
    }
}

#Preview("BasicShareLinkView") {
    BasicShareLinkView()
}

#Preview("ImageShareLinkView") {
    ImageShareLinkView()
}

#Preview("ContentView") {
    ContentView()
}
