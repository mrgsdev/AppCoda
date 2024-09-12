//
//  ContentView.swift
//  Chapter 3
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            ExtractedView()
//            ExtractedView2()
            ExtractedView3()
        }
     
        
    }
}

#Preview {
    ContentView()
}

struct ExtractedView: View {
    var body: some View {
        Image("paris")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .overlay(
                Color.black
                    .opacity(0.4)
                    .overlay(
                        Text("Paris")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundStyle(.white)
                            .frame(width: 200)
                    )
            )
    }
}

struct ExtractedView2: View {
    var body: some View {
        VStack {
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Text("If you are lucky enough to have lived in Paris as a young man, then wherever you go for the rest of your life it stays with you, for Paris is a moveab le feast.\n\n- Ernest Hemingway")
                        .fontWeight(.heavy)
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .padding(),
                    alignment: .top
                )
        }
    }
}

struct ExtractedView3: View {
    var body: some View {
        VStack {
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .clipShape(.circle)
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                        .opacity(0.5)
                )
        }
    }
}
