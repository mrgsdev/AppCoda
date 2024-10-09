//
//  Chapter_24App.swift
//  Chapter 24
//
//  Created by mrgsdev on 09.10.2024.
//

import SwiftUI

@main
struct Chapter_24App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDoItem.self)
    }
}
