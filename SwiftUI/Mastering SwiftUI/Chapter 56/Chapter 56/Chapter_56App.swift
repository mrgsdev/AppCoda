//
//  Chapter_56App.swift
//  Chapter 56
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import TipKit

@main
struct Chapter_56App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
