//
//  Photo.swift
//  Chapter 29
//
//  Created by mrgsdev on 14.10.2024.
//



import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
