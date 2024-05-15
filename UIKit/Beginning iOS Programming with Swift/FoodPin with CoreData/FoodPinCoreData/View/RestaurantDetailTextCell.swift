//
//  RestaurantDetailTextCell.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 02.05.2024.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {
//DescriptionCell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
