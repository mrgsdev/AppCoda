//
//  LoginViewController.swift
//  TouchID
//
//  Created by mrgsdev 15.05.2024.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var imageSet = ["cloud", "coffee", "food", "pmq", "temple"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Randomly pick an image
        let selectedImageIndex = Int(arc4random_uniform(5))
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        loginView.isHidden = true
        authenticateWithBiometric()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func authenticateWithPassword() {
        
        if emailTextField.text == "hi@appcoda.com" && passwordTextField.text == "1234" {
            performSegue(withIdentifier: "showHomeScreen", sender: nil)
        } else {
            // Shake to indicate wrong login ID/password
            loginView.transform = CGAffineTransform(translationX: 25, y: 0)
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                
                self.loginView.transform = CGAffineTransform.identity
                
            }, completion: nil)
        }
    }
    
    // MARK: - Helper methods

    func showLoginDialog() {
        // Move the login view off screen
        loginView.isHidden = false
        loginView.transform = CGAffineTransform(translationX: 0, y: -700)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.loginView.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }

    func authenticateWithBiometric() {
        // Get the local authentication context.
        let localAuthContext = LAContext()
        let reasonText = "Authentication is required to sign in AppCoda"
        var authError: NSError?
        
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            if let error = authError {
                print(error.localizedDescription)
            }
            
            // Display the login dialog when Touch ID is not available (e.g. in simulator)
            showLoginDialog()
            
            return
        }
        
        // Perform the Biometric authentication
        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonText, reply: { (success: Bool, error: Error?) -> Void in
            
            // Failure workflow
            if !success {
                if let error = error {
                    switch error {
                    case LAError.authenticationFailed:
                        print("Authentication failed")
                    case LAError.passcodeNotSet:
                        print("Passcode not set")
                    case LAError.systemCancel:
                        print("Authentication was canceled by system")
                    case LAError.userCancel:
                        print("Authentication was canceled by the user")
                    case LAError.biometryNotEnrolled:
                        print("Authentication could not start because you haven't enrolled either Touch ID or Face ID on your device.")
                    case LAError.biometryNotAvailable:
                        print("Authentication could not start because Touch ID / Face ID is not available.")
                    case LAError.userFallback:
                        print("User tapped the fallback button (Enter Password).")
                    default:
                        print(error.localizedDescription)
                    }
                }
                
                // Fallback to password authentication
                OperationQueue.main.addOperation({
                    self.showLoginDialog()
                })
              
            } else {
            
                // Success workflow
                
                print("Successfully authenticated")
                OperationQueue.main.addOperation({
                    self.performSegue(withIdentifier: "showHomeScreen", sender: nil)
                })
            }
            
        })
    }
}
