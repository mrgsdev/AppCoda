//
//  FaqView.swift
//  Chapter 28
//
//  Created by mrgsdev on 12.10.2024.
//


import SwiftUI

struct FaqView: View {
    @State var showContent = Array(repeating: false, count: 3)
  
    private let dataSet = [ (question: "Can I reuse the source code?", answer: "Absolutely! You are allowed to reuse the source code in your own projects (personal/commercial). However, you're not allowed to distribute or sell the source code without prior authorization."),
                            (question: "Will I get free update?", answer: "Yes! The update applies to all packages. Once you purchase the book, you will get free updates for 1 year."),
                            (question: "How can I get the book updates?", answer: "Whenever we update the learning materials, we will send you an email notification with the download instructions.")
                        ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(dataSet.indices, id: \.self) { index in
                    DisclosureGroup(
                        isExpanded: $showContent[index],
                        content: {
                            Text(dataSet[index].answer)
                                .font(.body)
                                .fontWeight(.light)
                        },
                        label: {
                            Text("\(index + 1). \(dataSet[index].question)")
                                .font(.body)
                                .bold()
                        }
                    )
                    .padding()
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("FAQ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showContent = self.showContent.map({ _ in true })
                    }, label: {
                        Text("Show all")
                    })
                }
            }
        }
        
    }
}

#Preview {
    FaqView()
}
