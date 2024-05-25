//
//  ProfileViewController.swift
//  Chapter 38
//
//  Created by mrgsdev on 25.05.2024
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!

    override func viewDidLoad() {
        self.title = "My Profile"
        if let currentUser = Auth.auth().currentUser {
            nameLabel.text = currentUser.displayName
        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // Present the welcome view
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }

    }
}
