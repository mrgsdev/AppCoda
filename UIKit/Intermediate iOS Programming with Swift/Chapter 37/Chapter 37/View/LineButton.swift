//
//  LineButton.swift
//  Chapter 37
//
//  Created by mrgsdev on 24.05.2024
//

import UIKit

@IBDesignable
class LineButton: UIButton {
    

    @IBInspectable var cornerRadius: Double = 0.0 {
        didSet {
            layer.cornerRadius = CGFloat(cornerRadius)
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: Double = 0.0 {
        didSet {
            layer.borderWidth = CGFloat(borderWidth)
        }
    }

    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var titleLeftPadding: Double = 0.0 {
        didSet {
            titleEdgeInsets.left = CGFloat(titleLeftPadding)
        }
    }
    
    @IBInspectable var titleRightPadding: Double = 0.0 {
        didSet {
            titleEdgeInsets.right = CGFloat(titleRightPadding)
        }
    }

    @IBInspectable var titleTopPadding: Double = 0.0 {
        didSet {
            titleEdgeInsets.top = CGFloat(titleTopPadding)
        }
    }

    @IBInspectable var titleBottomPadding: Double = 0.0 {
        didSet {
            titleEdgeInsets.bottom = CGFloat(titleBottomPadding)
        }
    }

    @IBInspectable var imageLeftPadding: Double = 0.0 {
        didSet {
            if !enableImageRightAligned {
                imageEdgeInsets.left = CGFloat(imageLeftPadding)
            }
        }
    }
    
    @IBInspectable var imageRightPadding: Double = 0.0 {
        didSet {
            imageEdgeInsets.right = CGFloat(imageRightPadding)
        }
    }
    
    @IBInspectable var imageTopPadding: Double = 0.0 {
        didSet {
            imageEdgeInsets.top = CGFloat(imageTopPadding)
        }
    }
    
    @IBInspectable var imageBottomPadding: Double = 0.0 {
        didSet {
            imageEdgeInsets.bottom = CGFloat(imageBottomPadding)
        }
    }
    
    @IBInspectable var enableImageRightAligned: Bool = false
    
    @IBInspectable var enableGradientBackground: Bool = false
    
    @IBInspectable var gradientColor1: UIColor = UIColor.black
    
    @IBInspectable var gradientColor2: UIColor = UIColor.white
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if enableImageRightAligned,
            let imageView = imageView {
            
            print("image view width = \(imageView.bounds.size.width)")
            print("frame = \(self.frame.size.width)")
            print("image view width = \(imageView.frame.size.width)")
                
            print("image left padding = \(imageLeftPadding)")
            imageEdgeInsets.left = self.bounds.width - imageView.bounds.size.width - CGFloat(imageLeftPadding)
        }
        
        if enableGradientBackground {
//            backgroundColor = UIColor.clear
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
