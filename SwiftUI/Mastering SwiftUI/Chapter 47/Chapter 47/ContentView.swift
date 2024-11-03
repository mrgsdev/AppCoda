//
//  ContentView.swift
//  Chapter 47
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

#Preview("landscapeLeft",traits: .landscapeLeft) {
    ContentView()
}

#Preview("sizeThatFitsLayout",traits: .sizeThatFitsLayout) {
    ContentView()
}
