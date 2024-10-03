//
//  Chapter_23App.swift
//  Chapter 23
//
//  Created by mrgsdev on 02.10.2024.
//

import SwiftUI

@main
struct Chapter_23App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDoItem.self)
    }
}
