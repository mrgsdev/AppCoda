//
//  PhotoDetailView.swift
//  Chapter 56
//
//  Created by mrgsdev on 20.10.2024.
//


import SwiftUI
import TipKit

struct PhotoDetailView: View {
    
    private let dragTip = DragTip()
    
    var body: some View {
        VStack {
            Image("flatiron")
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 50))
            
            TipView(dragTip)
                .padding(.top)
            
            Text("""
            The Flatiron Building, originally the Fuller Building, is a triangular 22-story, 285-foot-tall (86.9 m) steel-framed landmarked building at 175 Fifth Avenue in the eponymous Flatiron District neighborhood of the borough of Manhattan in New York City. Designed by Daniel Burnham and Frederick P. Dinkelberg, and known in its early days as "Burnham's Folly", it was completed in 1902 and originally included 20 floors. The building sits on a triangular block formed by Fifth Avenue, Broadway, and East 22nd Street—where the building's 87-foot (27 m) back end is located—with East 23rd Street grazing the triangle's northern (uptown) peak. The name "Flatiron" derives from its triangular shape, which recalls that of a cast-iron clothes iron.
            
            Source: Wikipedia
            """)
            .padding(.top)
        }
        .padding()
    
    }
}

#Preview {
    PhotoDetailView()
        .task {
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
}

struct DragTip: Tip {
    
    var title: Text {
        Text("Drag up and down")
    }
    
    var message: Text? {
        Text("You can drag up to reveal the full content or down to dismiss this view.")
    }

}
