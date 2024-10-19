//
//  Photo.swift
//  Chapter 34
//
//  Created by mrgsdev on 17.10.2024.
//


import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
