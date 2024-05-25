//
//  WelcomeViewController.swift
//  Chapter 38
//
//  Created by mrgsdev on 25.05.2024
//

import UIKit
//import FacebookLogin
import Firebase
import GoogleSignIn

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindtoWelcomeView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
//    @IBAction func facebook() {
//        let fbLoginManager = LoginManager()
//        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
//            if let error = error {
//                print("Failed to login: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let accessToken = AccessToken.current else {
//                print("Failed to get access token")
//                return
//            }
//
//            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
//            
//            // Perform login by calling Firebase APIs
//            Auth.auth().signIn(with: credential, completion: { (result, error) in
//                if let error = error {
//                    print("Login error: \(error.localizedDescription)")
//                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
//                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alertController.addAction(okayAction)
//                    self.present(alertController, animated: true, completion: nil)
//                    
//                    return
//                }
//                
//                // Present the main view
//                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                    UIApplication.shared.keyWindow?.rootViewController = viewController
//                    self.dismiss(animated: true, completion: nil)
//                }
//                
//            })
//
//        }
//    }
    @IBAction func google(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] user, error in
            
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
                
            } else {
                // Present the main view
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
    @IBAction func facebook(_ sender: UIButton) {
        
    }
}
