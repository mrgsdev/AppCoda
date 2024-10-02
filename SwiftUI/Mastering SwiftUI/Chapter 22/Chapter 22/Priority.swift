//
//  Priority.swift
//  Chapter 22
//
//  Created by mrgsdev on 02.10.2024.
//


import SwiftUI
import SwiftData

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

@Model class ToDoItem: Identifiable {
    var id: UUID
    var name: String
    @Transient var priority: Priority {
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            self.priorityNum = Int(newValue.rawValue)
        }
    }
    @Attribute(originalName: "priority") var priorityNum: Priority.RawValue
    
    var isComplete: Bool
    
    init(id: UUID = UUID(), name: String = "", priority: Priority = .normal, isComplete: Bool = false) {
        self.id = id
        self.name = name
        self.priorityNum = priority.rawValue
        self.isComplete = isComplete
    }
}

