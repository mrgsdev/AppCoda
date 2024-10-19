//
//  ContentView.swift
//  Chapter 34
//
//  Created by mrgsdev on 17.10.2024.
//
import SwiftUI

struct ContentView: View {
    @Namespace private var photoTransition
    
    @State private var photoSet = samplePhotos
    @State private var selectedPhotos: [Photo] = []
    @State private var selectedPhotoId: UUID?
    
    var body: some View {
        VStack {
            ScrollView {
                
                HStack {
                    Text("Photos")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                
                LazyVGrid(columns: [ GridItem(.adaptive(minimum: 50)) ]) {
                    
                    ForEach(photoSet) { photo in
                        
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 60)
                            .cornerRadius(3.0)
                            .onTapGesture {
                                selectedPhotos.append(photo)
                                selectedPhotoId = photo.id
                                if let index = photoSet.firstIndex(where: { $0.id == photo.id }) {
                                    photoSet.remove(at: index)
                                }
                            }
                            .matchedGeometryEffect(id: photo.id, in: photoTransition)
                    }
                }
            }
            
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [ GridItem() ]) {
                        ForEach(selectedPhotos) { photo in
                            Image(photo.name)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .cornerRadius(3.0)
                                .id(photo.id)
                                .onTapGesture {
                                    photoSet.append(photo)
                                    if let index = selectedPhotos.firstIndex(where: { $0.id == photo.id }) {
                                        selectedPhotos.remove(at: index)
                                    }
                                }
                                .matchedGeometryEffect(id: photo.id, in: photoTransition)
                        }
                    }
                }
                .frame(height: 100)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .onChange(of: selectedPhotoId) { oldValue, newValue in
                    withAnimation {
                        scrollProxy.scrollTo(newValue)
                    }
                }
            }
        }
        .padding()
        .animation(.interactiveSpring(), value: selectedPhotoId)
    }
}

#Preview {
    ContentView()
}
