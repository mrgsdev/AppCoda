//
//  ResetPasswordViewController.swift
//  Chapter 38
//
//  Created by mrgsdev on 25.05.2024
//

import UIKit
import Firebase 
class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: UIButton) {
        
        // Validate the input
        guard let emailAddress = emailTextField.text,
            emailAddress != "" else {
                
                let alertController = UIAlertController(title: "Input Error", message: "Please provide your email address for password reset.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // Send password reset email
        Auth.auth().sendPasswordReset(withEmail: emailAddress, completion: { (error) in
            
            let title = (error == nil) ? "Password Reset Follow-up" : "Password Reset Error"
            let message = (error == nil) ? "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password." : error?.localizedDescription
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                if error == nil {
                    
                    // Dismiss keyboard
                    self.view.endEditing(true)

                    // Return to the login screen
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
        })

    }
}
