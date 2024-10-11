//
//  ContentView.swift
//  Chapter 26
//
//  Created by mrgsdev on 11.10.2024.
//

import SwiftUI

struct ContentView: View {
    @Namespace var nsArticle
    
    @State private var showContent = false
    @State private var selectedArticleIndex: Int?
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 40) {
                    
                    TopBarView()
                        .padding(.horizontal, 20)
                    
                    ForEach(sampleArticles.indices, id: \.self) { index in
                        
                        ArticleCardView(category: sampleArticles[index].category, headline: sampleArticles[index].headline, subHeadline: sampleArticles[index].subHeadline, image: sampleArticles[index].image, content: sampleArticles[index].content, isShowContent: $showContent)
                        
                            .padding(.horizontal, 20)
                            .matchedGeometryEffect(id: index, in: nsArticle)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.65, blendDuration: 0.1)) {
                                    self.selectedArticleIndex = index
                                    self.showContent.toggle()
                                }
                            }
                            .frame(height: min(sampleArticles[index].image.size.height/3, 500))
                            
                    }
                }
            }
            .opacity(showContent ? 0 : 1)
            
            if showContent,
               let selectedArticleIndex {
                ArticleCardView(category: sampleArticles[selectedArticleIndex].category, headline: sampleArticles[selectedArticleIndex].headline, subHeadline: sampleArticles[selectedArticleIndex].subHeadline, image: sampleArticles[selectedArticleIndex].image, content: sampleArticles[selectedArticleIndex].content, isShowContent: $showContent)
                    .matchedGeometryEffect(id: selectedArticleIndex, in: nsArticle)
                    .ignoresSafeArea()
            }
        }
    }
}

struct TopBarView : View {
   
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading) {
                Text(getCurrentDate().uppercased())
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            
            Spacer()
            
            AvatarView(image: "profile", width: 40, height: 40)
            
        }
    }
    
    func getCurrentDate(with format: String = "EEEE, MMM d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
}

struct AvatarView: View {
    let image: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    ContentView()
}
