//
//  AppDelegate.swift
//  Chapter 38
//
//  Created by mrgsdev on 25.05.2024
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set up the style and color of the common UI elements
        customizeUIStyle()
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func customizeUIStyle() {
        
        // Customize Navigation bar items
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        var handled: Bool = false
//        if url.absoluteString.contains("fb") {
////            handled = ApplicationDelegate.shared.application(
////                app,
////                open: url,
////                sourceApplication: options[UIApplication.OpenURLOptionsKey.sou
////                                           rceApplication] as? String,
////                annotation: options[UIApplication.OpenURLOptionsKey.annotation
////                                   ]
////            )
//        } else {
//            handled = GIDSignIn.sharedInstance.handle(url)
//        }
//        return handled
//    }
}
