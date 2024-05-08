//
//  HotelTableViewCell.swift
//  Chapter 25
//
//  Created by mrgsdev on 06.05.2024.
//

import UIKit

class HotelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:UILabel! {
        didSet {
            nameLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var addressLabel:UILabel! {
        didSet {
            addressLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var descriptionLabel:UILabel! {
        didSet {
            descriptionLabel.adjustsFontForContentSizeCategory = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
