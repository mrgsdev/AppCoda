//
//  ToDoItem.swift
//  Chapter 52
//
//  Created by mrgsdev on 20.10.2024.
//


import Foundation
import SwiftData

@Model class ToDoItem: Identifiable {
    var id: UUID
    var name: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), name: String = "", isComplete: Bool = false) {
        self.id = id
        self.name = name
        self.isComplete = isComplete
    }
}
