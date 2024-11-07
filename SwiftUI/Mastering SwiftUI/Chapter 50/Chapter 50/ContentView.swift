//
//  ContentView.swift
//  Chapter 50
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    let bgColors: [Color] = [ .yellow, .blue, .orange, .indigo, .green ]
    
    @State private var scrollID: Int?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0...50, id: \.self) { index in
                    
                    bgColors[index % 5]
                        .frame(height: 300)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(.white)
                                .font(.system(.title, weight: .bold))
                        }
                        .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)
                                .rotation3DEffect(.radians(phase.value), axis: (1, 1, 1))
                        }
                        
                        .onTapGesture {
                            withAnimation {
                                scrollID = 0
                            }
                        }
                        
                }
            }
            .scrollTargetLayout()

        }
        .contentMargins(10.0, for: .scrollContent)
        .scrollPosition(id: $scrollID)

        
    }
}

#Preview {
    ContentView()
}
