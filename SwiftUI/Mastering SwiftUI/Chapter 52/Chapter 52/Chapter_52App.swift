//
//  Chapter_52App.swift
//  Chapter 52
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI

@main
struct Chapter_52App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
        .modelContainer(for: ToDoItem.self)
    }
}
