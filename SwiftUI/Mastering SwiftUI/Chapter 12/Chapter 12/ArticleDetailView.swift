//
//  ArticleDetailView.swift
//  Chapter 12
//
//  Created by mrgsdev on 21.09.2024.
//


import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                Group {
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                        
                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                
                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // Navigate to the previous screen
                    dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(article: articles[0])
      
        .navigationTitle("Article")
    }
}

