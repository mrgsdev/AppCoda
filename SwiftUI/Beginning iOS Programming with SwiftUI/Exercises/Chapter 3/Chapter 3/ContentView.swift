//
//  ContentView.swift
//  Chapter 3
//
//  Created by mrgsdev on 19.08.2024.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
   
    
    var body: some View {
        VStack {
            ButtonsView()
        }
    }
        
    
}

#Preview {
    ContentView()
}

struct ButtonsView: View {
    let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Fred")
        
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        VStack {
            
            Text("Guess These Movies")
                .fontWeight(.bold)
                .font(.largeTitle)
            
            Text("Can you guess the movie from these emojis?")
            
            Text("Tap the button to find out the answer")
            
            Button {
                speak(text: "The answer is Back to the Future!")
            } label: {
                Text("👦🏻👴🏻🚗⌚️")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                speak(text: "The answer is Frozen!")
            } label: {
                Text("🏰👭🌀❄️☃️")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                speak(text: "The answer is Ocean 11!")
            } label: {
                Text("🌊1️⃣1️⃣")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                speak(text: "The answer is Spiderman!")
            } label: {
                Text("🕷🏃")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(.brown)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
