//
//  ContentView.swift
//  Chapter 32
//
//  Created by mrgsdev on 14.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var wordCount: Int = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TextEditor(text: $inputText)
                .font(.body)
                .padding()
                .padding(.top, 20)
                .onChange(of: inputText) {
                    let words = inputText.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
            
            Text("\(wordCount) words")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
    }
}

#Preview {
    ContentView()
}


struct TextFieldDemo: View {
    @State private var comment = ""
    
    var body: some View {
        TextField("Comment", text: $comment, prompt: Text("Please input your comment"), axis: .vertical)
            .padding()
            .background(.green.opacity(0.2))
            .cornerRadius(5.0)
            .padding()
            
    }
}

#Preview("TextFieldDemo") {
    TextFieldDemo()
}
