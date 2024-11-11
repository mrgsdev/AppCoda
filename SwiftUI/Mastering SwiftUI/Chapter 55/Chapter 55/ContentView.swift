//
//  ContentView.swift
//  Chapter 55
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    struct AnimationValues {
        var scale = 1.0
        var verticalStretch = 1.0
        var translation = CGSize.zero
        var opacity = 1.0
    }
    
    @State private var startAnimate = false
    
    var body: some View {
        Text("🐻")
            .font(.system(size: 100))
            .keyframeAnimator(initialValue: AnimationValues(), repeating: startAnimate) { content, value in
                
                content
                    .scaleEffect(value.scale)
                    .scaleEffect(y: value.verticalStretch)
                    .offset(value.translation)
                    .opacity(value.opacity)
                
            } keyframes: { _ in
                
                KeyframeTrack(\.verticalStretch) {
                    LinearKeyframe(1.2, duration: 0.1)
                    SpringKeyframe(2.0, duration: 0.2, spring: .snappy)
                    CubicKeyframe(1.05, duration: 0.3)
                    CubicKeyframe(1.2, duration: 0.2)
                    CubicKeyframe(1.1, duration: 0.32)
                    CubicKeyframe(1.2, duration: 0.2)
                    CubicKeyframe(1.05, duration: 0.25)
                    CubicKeyframe(1.3, duration: 0.23)
                    CubicKeyframe(1.0, duration: 0.3)
                }
                
                KeyframeTrack(\.scale) {
                    CubicKeyframe(0.8, duration: 0.2)
                    CubicKeyframe(0.6, duration: 0.3)
                    CubicKeyframe(1.0, duration: 0.3)
                    CubicKeyframe(0.8, duration: 0.2)
                    CubicKeyframe(0.6, duration: 0.3)
                    CubicKeyframe(1.0, duration: 0.3)
                }
                
                
                KeyframeTrack(\.translation) {
                    SpringKeyframe(CGSize(width: 100, height: 100), duration: 0.4)
                    SpringKeyframe(CGSize(width: -50, height: -300), duration: 0.4)
                    SpringKeyframe(.zero, duration: 0.2)
                    SpringKeyframe(CGSize(width: -50, height: 200), duration: 0.3)
                    SpringKeyframe(CGSize(width: -90, height: 300), duration: 0.3)
                    SpringKeyframe(.zero, duration: 0.4)
                }
                
                
                KeyframeTrack(\.opacity) {
                    LinearKeyframe(0.5, duration: 0.2)
                    LinearKeyframe(1.0, duration: 0.23)
                    LinearKeyframe(0.7, duration: 0.25)
                    LinearKeyframe(1.0, duration: 0.33)
                    LinearKeyframe(0.8, duration: 0.2)
                    LinearKeyframe(1.0, duration: 0.23)
                }

            }
            .onTapGesture {
                startAnimate.toggle()
            }
    }
}

#Preview {
    ContentView()
}

struct TwoEmojiAnimationView: View {
    
    struct AnimationValues {
        var scale = 1.0
        var verticalStretch = 1.0
        var translation = CGSize.zero
        var opacity = 1.0
    }
    
    @State private var startAnimate = false
    
    var body: some View {
        ZStack {
            Text("🐻")
                .font(.system(size: 100))
                .keyframeAnimator(initialValue: AnimationValues(), repeating: startAnimate) { content, value in
                    
                    content
                        .scaleEffect(value.scale)
                        .scaleEffect(y: value.verticalStretch)
                        .offset(value.translation)
                        .opacity(value.opacity)
                    
                } keyframes: { _ in
                    
                    KeyframeTrack(\.verticalStretch) {
                        LinearKeyframe(1.2, duration: 0.1)
                        SpringKeyframe(2.0, duration: 0.2, spring: .snappy)
                        CubicKeyframe(1.05, duration: 0.3)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.1, duration: 0.32)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.05, duration: 0.25)
                        CubicKeyframe(1.3, duration: 0.23)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    
                    KeyframeTrack(\.translation) {
                        SpringKeyframe(CGSize(width: 100, height: 100), duration: 0.4)
                        SpringKeyframe(CGSize(width: -50, height: -300), duration: 0.4)
                        SpringKeyframe(.zero, duration: 0.2)
                        SpringKeyframe(CGSize(width: -50, height: 200), duration: 0.3)
                        SpringKeyframe(CGSize(width: -90, height: 300), duration: 0.3)
                        SpringKeyframe(.zero, duration: 0.4)
                    }
                    
                    
                    KeyframeTrack(\.opacity) {
                        LinearKeyframe(0.5, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                        LinearKeyframe(0.7, duration: 0.25)
                        LinearKeyframe(1.0, duration: 0.33)
                        LinearKeyframe(0.8, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                    }

                }
                .onTapGesture {
                    startAnimate.toggle()
                }
            
            Text("🐵")
                .font(.system(size: 100))
                .keyframeAnimator(initialValue: AnimationValues(), repeating: startAnimate) { content, value in
                    
                    content
                        .scaleEffect(value.scale)
                        .scaleEffect(y: value.verticalStretch)
                        .offset(value.translation)
                        .opacity(value.opacity)
                    
                } keyframes: { _ in
                    
                    KeyframeTrack(\.verticalStretch) {
                        LinearKeyframe(1.2, duration: 0.1)
                        SpringKeyframe(2.0, duration: 0.2, spring: .snappy)
                        CubicKeyframe(1.05, duration: 0.3)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.1, duration: 0.32)
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.05, duration: 0.25)
                        CubicKeyframe(1.3, duration: 0.23)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                    
                    
                    KeyframeTrack(\.translation) {
                        SpringKeyframe(CGSize(width: 200, height: 300), duration: 0.4)
                        SpringKeyframe(CGSize(width: -80, height: -200), duration: 0.3)
                        SpringKeyframe(CGSize(width: 90, height: 100), duration: 0.3)
                        SpringKeyframe(CGSize(width: 200, height: -400), duration: 0.2)
                        SpringKeyframe(CGSize(width: -40, height: 400), duration: 0.5)
                        SpringKeyframe(.zero, duration: 0.4)
                    }
                    
                    
                    KeyframeTrack(\.opacity) {
                        LinearKeyframe(0.5, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                        LinearKeyframe(0.7, duration: 0.25)
                        LinearKeyframe(1.0, duration: 0.33)
                        LinearKeyframe(0.8, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.23)
                    }

                }
                .onTapGesture {
                    startAnimate.toggle()
            }

        }
    }
}

#Preview("TwoEmojiAnimationView") {
    TwoEmojiAnimationView()
}



