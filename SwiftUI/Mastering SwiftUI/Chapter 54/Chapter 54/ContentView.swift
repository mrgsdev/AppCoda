//
//  ContentView.swift
//  Chapter 54
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(height: 200)
            .phaseAnimator([ false, true ]) { content, phase in
                content
                    .scaleEffect(phase ? 1.0 : 0.5)
                    .foregroundStyle(phase ? .indigo : .blue)
                    .rotation3DEffect(
                        phase ? .degrees(720) : .zero,
                                              axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            } animation: { phase in
                switch phase {
                case true: .smooth.speed(0.2)
                case false: .spring
                }
            }

    }
}





#Preview("ContentView") {
    ContentView()
}


struct EmojiAnimation: View {
    
    @State private var startAnimation = false
    
    enum Phase: CaseIterable {
        case initial
        case rotate
        case jump
        case fall
        
        var scale: Double {
            switch self {
            case .initial: 1.0
            case .rotate: 1.5
            case .jump: 0.8
            case .fall: 0.5
            }
        }
        
        var angle: Angle {
            switch self {
            case .initial, .jump: Angle(degrees: 0)
            case .rotate: Angle(degrees: 720)
            case .fall: Angle(degrees: 360)
            }
        }
        
        var offset: Double {
            switch self {
            case .initial, .rotate: 0
            case .jump: -250.0
            case .fall: 450.0
            }
        }
    }
    
    var body: some View {
        Text("🐻")
            .font(.system(size: 100))
            .phaseAnimator(Phase.allCases, trigger: startAnimation, content: { content, phase in
                content
                    .scaleEffect(phase.scale)
                    .rotationEffect(phase.angle)
                    .offset(y: phase.offset)
            }, animation: { phase in
                switch phase {
                case .initial: .bouncy
                case .rotate: .smooth
                case .jump: .snappy
                case .fall: .interactiveSpring
                }
            })
            .onTapGesture {
                startAnimation.toggle()
            }
    }
}


#Preview("EmojiAnimation") {
    EmojiAnimation()
}


struct AnimatedRectView: View {
    @State private var startAnimation = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(height: 200)
            .phaseAnimator([ false , true ], trigger: startAnimation, content: { content, phase in
                content
                    .scaleEffect(phase ? 1.0 : 0.5)
                    .foregroundStyle(phase ? .indigo : .blue)
                    .rotation3DEffect(
                        phase ? .degrees(720) : .zero,
                                              axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    
            }, animation: { phase in
                switch phase {
                case true: .smooth.speed(0.2)
                case false: .spring
                }
            })
            .onTapGesture {
                startAnimation.toggle()
            }
    }
}

#Preview("AnimatedRect") {
    AnimatedRectView()
}
