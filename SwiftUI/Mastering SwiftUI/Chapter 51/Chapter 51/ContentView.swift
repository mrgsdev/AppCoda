//
//  ContentView.swift
//  Chapter 51
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animate = false
    
    var body: some View {
  
        ZStack {
            ForEach(0..<18, id: \.self) { index in
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20.0, bottomLeading: 5.0, bottomTrailing: 20.0, topTrailing: 10.0), style: .continuous)
                    .foregroundStyle(.indigo)
                    .frame(width: 300, height: 30)
                    .opacity(animate ? 0.6 : 1.0)
                    .rotationEffect(.degrees(Double(10 * index)))
                    .animation(.easeInOut.delay(Double(index) * 0.02), value: animate)
            }
        }
        .overlay {
            Image(systemName: "briefcase")
                .foregroundStyle(.white)
                .font(.system(size: 100))
        }
        .onTapGesture {
            animate.toggle()
        }

    }
}


struct ButtonView: View {
    var body: some View {
        
        VStack {
            Button(action: {
                
            }) {
                Text("Register")
                    .font(.title)
            }
            .tint(.white)
            .frame(width: 300, height: 100)
            .background {
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 50.0, bottomLeading: 10.0, bottomTrailing: 50.0, topTrailing: 30.0), style: .continuous)
                    .foregroundStyle(.indigo)
            }
        }
         
    }
}

struct AnimatedCornerView: View {
    
    @State private var animate = false
    
    var body: some View {

        UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: animate ? 10.0 : 80.0,
                                    bottomLeading: animate ? 80.0 : 10.0,
                                    bottomTrailing: animate ? 80.0 : 10.0,
                                    topTrailing: animate ? 10.0 : 80.0))
            .foregroundStyle(.indigo)
            .frame(height: 200)
            .padding()
            .onTapGesture {
                withAnimation {
                    animate.toggle()
                }
            }

    }
}

#Preview("Animated Unique Shape") {
    ContentView()
}

#Preview("Button View") {
    ButtonView()
}

#Preview("Animated Corner View") {
    AnimatedCornerView()
}
