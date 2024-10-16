//
//  Task.swift
//  Chapter 31
//
//  Created by mrgsdev on 14.10.2024.
//


import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var name: String = ""
    var progress: Double = 0.0 {
        didSet {
            progress = min(progress, 1.0)
        }
    }
    
    init(name: String, progress: Double = 0.0) {
        self.name = name
        self.progress = progress
    }
}

