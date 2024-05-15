//
//  RestaurantDetailHeaderView.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 02.05.2024.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!{
        didSet {
            nameLabel.numberOfLines = 0
            nameLabel.adjustsFontForContentSizeCategory = true
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
                
            }
        }
    }
    @IBOutlet var typeLabel: UILabel!{
        didSet {
            typeLabel.numberOfLines = 0
            typeLabel.adjustsFontForContentSizeCategory = true
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
                typeLabel.layer.cornerRadius = 5
                typeLabel.clipsToBounds = true
            }
        }
    }
    @IBOutlet var heartButton: UIButton!
    
}
