//
//  ContentView.swift
//  Chapter 31
//
//  Created by mrgsdev on 14.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                ProgressRingView(progress: $progress,
                                 thickness: 30,
                                 width: 300,
                                 gradient: Gradient(colors: [.darkPurple, .lightPurple]))
                
                ProgressRingView(progress: $progress,
                                 thickness: 30,
                                 width: 235,
                                 gradient: Gradient(colors: [.darkYellow, .lightYellow]))
                
                ProgressRingView(progress: $progress,
                                 thickness: 30,
                                 width: 170,
                                 gradient: Gradient(colors: [.darkGreen, .lightGreen]))
                
                
            }
            
            HStack {
                Group {
                    Text("25%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.25
                        }
                    
                    Text("50%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.5
                        }
                    
                    Text("75%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.75
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
                
            }
            .padding(.top, 50)
        }
    }
}


#Preview {
    ContentView()
}
