//
//  ContentView.swift
//  Chapter 53
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [Image] = []
    
    var body: some View {
        VStack {
            if selectedImages.isEmpty {
                ContentUnavailableView("No Photos", systemImage: "photo.on.rectangle", description: Text("To get started, select some photos below"))
                    .frame(height: 300)
            } else {
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<selectedImages.count, id: \.self) { index in
                            selectedImages[index]
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .padding(.horizontal, 20)
                                .containerRelativeFrame(.horizontal)
                        }
                        
                    }
                }
                .frame(height: 300)
            }

            
            Spacer()
            
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, selectionBehavior: .continuousAndOrdered,
                         matching: .images) {
                Label("Select a photo", systemImage: "photo")
            }
            .photosPickerStyle(.inline)
            .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
            .frame(height:  500)
            .ignoresSafeArea()
            .onChange(of: selectedItems) { oldItems, newItems in
                
                selectedImages.removeAll()
                
                newItems.forEach { newItem in
                
                    Task {
                        if let image = try? await newItem.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }

                }
            }
        }
        
        
    }
}









struct ContentViewFinal: View {
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        VStack {
            
            if selectedImages.isEmpty {
                ContentUnavailableView("No Photos", systemImage: "photo.on.rectangle", description: Text("To get started, select some photos below"))
                    .frame(height: 300)
            } else {
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .padding(.horizontal, 20)
                                .containerRelativeFrame(.horizontal)
                        }
                        
                    }
                }
                .frame(height: 300)
                
                
            }
            
            
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, selectionBehavior: .continuousAndOrdered, matching: .images) {
                Label("Select a photo", systemImage: "photo")
            }
            .photosPickerStyle(.inline)
            .photosPickerAccessoryVisibility(.hidden, edges: .all)
            .photosPickerDisabledCapabilities(.selectionActions)
            .ignoresSafeArea()
            .onChange(of: selectedItems) { oldItems, newItems in
                
                print("Old items: \(oldItems.count)")
                print("New items: \(newItems.count)")
                selectedImages = []
                
                newItems.forEach { newItem in
                
                    Task {
                    
                        if let data = try? await newItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                selectedImages.append(image)
                            }
                        }
                        
                    }

                }
            }
            /*
            PhotosPicker(selection: $selectedItems,
                         selectionBehavior: .continuous,
                         matching: .images) {
                Label("Select a photo", systemImage: "photo")
            }
            */
            
        }
        
    }
}

#Preview {
    ContentView()
}
