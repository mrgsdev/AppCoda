//
//  Chapter_14App.swift
//  Chapter 14
//
//  Created by mrgsdev on 23.09.2024.
//

import SwiftUI

@main
struct Chapter_14App: App {
    var settingStore = SettingStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settingStore)
        }
    }
}
