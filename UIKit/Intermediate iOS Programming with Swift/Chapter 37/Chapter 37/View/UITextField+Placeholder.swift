//
//  UITextField+Placeholder.swift
//  Chapter 37
//
//  Created by mrgsdev on 24.05.2024
//

import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        
        set {
            if let placeholder = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: newValue!])
            }
        }
    }
}

