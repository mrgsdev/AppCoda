//
//  ContentView.swift
//  Chapter 30
//
//  Created by mrgsdev on 14.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            ProgressRingView(progress: $progress)
            
            HStack {
                Group {
                    Text("0%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.0
                        }
                    
                    Text("50%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.5
                        }
                    
                    Text("100%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 1.0
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
