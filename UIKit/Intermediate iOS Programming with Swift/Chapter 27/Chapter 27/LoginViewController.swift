//
//  LoginViewController.swift
//  Chapter 27
//
//  Created by mrgsdev 14.05.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    private let imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
    private var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Randomly pick an image
        let selectedImageIndex = Int.random(in: 0..<imageSet.count)
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }
}
