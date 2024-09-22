//
//  ContentView 2.swift
//  Chapter 12
//
//  Created by mrgsdev on 21.09.2024.
//


import SwiftUI

struct ContentViewSecondProject: View {
    var body: some View {
        NavigationStack {
            List(articles) { article in
                ZStack {
                    ArticleRow(article: article)
                    
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        EmptyView()
                    }
                    .opacity(0)
                     
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Your Reading")
        }
        
    }
}

#Preview {
    ContentViewSecondProject()
}

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}
