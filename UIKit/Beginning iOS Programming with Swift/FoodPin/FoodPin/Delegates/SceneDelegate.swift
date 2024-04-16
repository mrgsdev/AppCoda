//
//  SceneDelegate.swift
//  FoodPin
//
//  Created by mrgsdev on 10.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    enum QuickAction: String {
        case OpenFavorites = "OpenFavorites"
        case OpenDiscover = "OpenDiscover"
        case NewRestaurant = "NewRestaurant"
        init?(fullIdentifier: String) {
            guard let shortcutIdentifier = fullIdentifier.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: shortcutIdentifier)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
            
            completionHandler(handleQuickAction(shortcutItem: shortcutItem))
        }

        private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {

            let shortcutType = shortcutItem.type
            guard let shortcutIdentifier = QuickAction(fullIdentifier: shortcutType) else {
                return false
            }

            guard let tabBarController = window?.rootViewController as? UITabBarController else {
                return false
            }

            switch shortcutIdentifier {
            case .OpenFavorites:
                tabBarController.selectedIndex = 0
            case .OpenDiscover:
                tabBarController.selectedIndex = 1
            case .NewRestaurant:
                if let navController = tabBarController.viewControllers?[0] {
                    let restaurantTableViewController = navController.children[0]
                    restaurantTableViewController.performSegue(withIdentifier: "addRestaurant", sender: restaurantTableViewController)
                } else {
                    return false
                }
            }

            return true
        }

    
}

