//
//  SolutionToExercise.swift
//  Chapter 6
//
//  Created by mrgsdev on 10.09.2024.
//

import SwiftUI

struct SolutionToExercise: View {
    var body: some View {
        Button(action: {
            print("Plus button tapped")
        }) {
            Image(systemName: "plus")
        }
        .buttonStyle(CircularStyle())
    }
}

struct CircularStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotationEffect(configuration.isPressed ? Angle(degrees: 135) : Angle(degrees: 0))
    }
}

#Preview {
    SolutionToExercise()
}
