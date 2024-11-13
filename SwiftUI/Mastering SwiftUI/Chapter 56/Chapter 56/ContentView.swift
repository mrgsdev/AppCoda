//
//  ContentView.swift
//  Chapter 56
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    private let favoriteTip = FavoriteTip()
    private let getStartedTip = GetStartedTip()
    
    @State private var showDetail = false
    
    var body: some View {
        
        VStack {
            Image("flatiron")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "heart")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .padding()
                        .popoverTip(favoriteTip, arrowEdge: .top)
                }
                .onTapGesture {
                    withAnimation {
                        showDetail.toggle()
                    }
                    
                    
                    getStartedTip.invalidate(reason: .actionPerformed)
                    
                    Task {
                        await FavoriteTip.hasViewedGetStartedTip.donate()
                    }
                    
              //      FavoriteTip.hasViewedGetStartedTip = true
                }
            
            if showDetail {
                Text("The Flatiron Building, originally the Fuller Building, is a triangular 22-story, 285-foot-tall (86.9 m) steel-framed landmarked building at 175 Fifth Avenue in the eponymous Flatiron District neighborhood of the borough of Manhattan in New York City.")
                    .padding(.top)
                    .transition(.scale)
            }
            
            TipView(getStartedTip)
        }
        .padding()
        
        
    }
}

#Preview {
    ContentView()
        .task {
            try? Tips.resetDatastore()
            
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
}

struct FavoriteTip: Tip {
    
    var title: Text {
        Text("Save the photo as favorite")
    }
    
    var message: Text? {
        Text("Your favorite photos will appear in the favorite folder.")
    }
    
    
    var rules: [Rule] {
        #Rule(Self.hasViewedGetStartedTip) {
            $0.donations.count >= 1
        }
    
        
       // #Rule(Self.$hasViewedGetStartedTip) { $0 == true }
    }
    
    /*
    @Parameter
    static var hasViewedGetStartedTip: Bool = false

     */
    
    static let hasViewedGetStartedTip = Tips.Event(id: "hasViewedGetStartedTip")
}

struct GetStartedTip: Tip {
    var title: Text {
        Text("Getting Started")
    }
    
    var message: Text? {
        Text("Swipe left/right to navigate and tap a photo to reveal its details")
    }
    
    var image: Image? {
        Image(systemName: "hand.tap")
    }
    
}

