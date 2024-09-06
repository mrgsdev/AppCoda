//
//  FoodPinApp.swift
//  FoodPin
//
//  Created by mrgsdev on 21.08.2024.
//

import SwiftUI

@main
struct FoodPinApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Restaurant.self)
        .onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
            case .background:
                createQuickActions()
            @unknown default:
                print("Default scene phase")
            }
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") ?? UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") ?? UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    func createQuickActions() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "tag"), userInfo: nil)
            let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "eyes"), userInfo: nil)
            let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
        }
    }
}

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @Environment(\.openURL) private var openURL: OpenURLAction
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem: shortcutItem))
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let shortcutItem = connectionOptions.shortcutItem else {
            return
        }

        handleQuickAction(shortcutItem: shortcutItem)
    }
    
    private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        let shortcutType = shortcutItem.type
        
        guard let shortcutIdentifier = shortcutType.components(separatedBy: ".").last else {
            return false
        }
        
        guard let url = URL(string: "foodpinapp://actions/" + shortcutIdentifier) else {
            print("Failed to initiate the url")
            return false
        }
        
        openURL(url)
        
        return true
    }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Main Scene", sessionRole: connectingSceneSession.role)
        
        configuration.delegateClass = MainSceneDelegate.self
        
        return configuration
    }
}
