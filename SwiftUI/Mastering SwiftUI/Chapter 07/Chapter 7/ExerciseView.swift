//
//  ExerciseView.swift
//  Chapter 7
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct ExerciseView: View {
    @State private var counterBlue = 0
    @State private var counterGreen = 0
    @State private var counterRed = 0
    
    var body: some View {
        VStack {
            Text("\(counterBlue + counterGreen + counterRed)")
                .font(.system(size: 220, weight: .bold, design: .rounded))
            
            HStack {
                CounterButtonExercise(counter: $counterBlue, color: .blue)
                CounterButtonExercise(counter: $counterGreen, color: .green)
                CounterButtonExercise(counter: $counterRed, color: .red)
            }
        }
    }
}

struct CounterButtonExercise: View {
    @Binding var counter: Int
    
    var color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundStyle(color)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    ExerciseView()
}
