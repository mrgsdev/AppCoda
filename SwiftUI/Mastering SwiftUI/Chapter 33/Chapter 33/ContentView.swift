//
//  ContentView.swift
//  Chapter 33
//
//  Created by mrgsdev on 17.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var shapeTransition
    
    @State private var expand = false
    
    var body: some View {
        VStack {
            if expand {
                
                // Rounded Rectangle
                Spacer()
                
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                    .padding()
                    .foregroundColor(Color(.systemGreen))
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }

            } else {
                
                // Circle
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(.systemOrange))
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct CircleToFullScreenView: View {
    @Namespace private var shapeTransition
    @State private var expand = false
    
    var body: some View {
        VStack {
            if expand {
                RoundedRectangle(cornerRadius: 20.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .foregroundStyle(.green)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
                
            } else {
                Spacer()
                
                // Circle
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color(.systemOrange))
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
            }
        }
    }
}

#Preview("CircleToFullScreen") {
    CircleToFullScreenView()
}

struct SwapTwoDotsView: View {
    @State private var swap = false

    @Namespace private var dotTransition
    
    var body: some View {
        if swap {
            
            // After swap
            // Green dot on the left, Orange dot on the right

            HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
                
                Spacer()
                
                Circle()
                    .fill(.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
            }
            .frame(width: 100)
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
            
        } else {
            
            // Start state
            // Orange dot on the left, Green dot on the right
            
            HStack {
                Circle()
                    .fill(.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
                
                Spacer()
                
                Circle()
                    .fill(.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
            }
            .frame(width: 100)
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
        }
    }
}

#Preview("SwapDotView") {
    SwapTwoDotsView()
}

struct SwapPhotoView: View {
    @State private var swap = false
    
    @Namespace private var photoTransition
    
    var body: some View {
        if swap {
            HStack {
                Image("espresso")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "photo1", in: photoTransition)
                    .clipped()
                
                
                Image(systemName: "arrow.right.arrow.left")
                    .font(.system(size: 40))
                    .onTapGesture {
                        withAnimation(.linear) {
                            swap.toggle()
                        }
                    }
                
                Image("latte")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "photo2", in: photoTransition)
                    .clipped()
                
            }
            
            
        } else {
            HStack {
                Image("latte")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "photo2", in: photoTransition)
                    .clipped()
                
                
                Image(systemName: "arrow.right.arrow.left")
                    .font(.system(size: 40))
                    .onTapGesture {
                        withAnimation(.linear) {
                            swap.toggle()
                        }
                    }
                
                Image("espresso")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "photo1", in: photoTransition)
                    .clipped()
                
            }
            
        }
    }
}

#Preview("SwapPhotoView") {
    SwapPhotoView()
}

struct HeroAnimationView: View {
    @State private var showDetail = false
    
    @Namespace private var articleTransition
    
    var body: some View {
        
        // Display an article view with smaller image
        if !showDetail {
            ArticleExcerptView(showDetail: $showDetail, articleTransition: articleTransition)
        }
        
        // Display the article view in a full screen
        if showDetail {
            ArticleDetailView(showDetail: $showDetail, articleTransition: articleTransition)
        }
        
    }
}

struct ArticleExcerptView: View {
    
    @Binding var showDetail: Bool
    
    var articleTransition: Namespace.ID
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("latte")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .matchedGeometryEffect(id: "image", in: articleTransition)
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2)) {
                            showDetail.toggle()
                        }
                    }
                
                Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta.")
                    .matchedGeometryEffect(id: "text", in: articleTransition)
                    .padding(.horizontal)
                
            }
        }
    }
}

struct ArticleDetailView: View {
    @Binding var showDetail: Bool
    
    var articleTransition: Namespace.ID
    
    var body: some View {
        ScrollView {
            VStack {
                Image("latte")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 400)
                    .clipped()
                    .matchedGeometryEffect(id: "image", in: articleTransition)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.4)) {
                            showDetail.toggle()
                        }
                    }
                
                Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta. The restaurant features a full menu of moderately priced \"comfort\" food influenced by African and French cooking traditions, but based upon time honored recipes from around the world. The cafe section of The Watertower features a coffeehouse with a dessert bar, magazines, and space for live performers.\n\nThe Watertower will be owned and operated by The Watertower LLC, a Georgia limited liability corporation managed by David N. Patton IV, a resident of the Empowerment Zone. The members of the LLC are David N. Patton IV (80%) and the Historic District Development Corporation (20%).\n\nThis business plan offers financial institutions an opportunity to review our vision and strategic focus. It also provides a step-by-step plan for the business start-up, establishing favorable sales numbers, gross margin, and profitability.\n\nThis plan includes chapters on the company, products and services, market focus, action plans and forecasts, management team, and financial plan.")
                    .matchedGeometryEffect(id: "text", in: articleTransition)
                    .animation(nil, value: showDetail)
                    .padding(.all, 20)
                
                Spacer()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview("HeroAnimationView") {
    HeroAnimationView()
}
