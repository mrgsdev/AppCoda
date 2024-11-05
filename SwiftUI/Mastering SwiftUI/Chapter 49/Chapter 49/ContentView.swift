//
//  ContentView.swift
//  Chapter 49
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
                        .frame(height: 100)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(.white)
                                .font(.system(.title, weight: .bold))
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
        .contentMargins(50.0, for: .scrollContent)
        .scrollPosition(id: $scrollID)
        .onChange(of: scrollID) { oldValue, newValue in
            print(newValue ?? "")
        }
        
    }
}


#Preview {
    ContentView()
}
