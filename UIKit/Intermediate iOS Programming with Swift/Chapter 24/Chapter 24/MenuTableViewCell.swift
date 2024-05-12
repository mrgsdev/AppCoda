//
//  MenuTableViewCell.swift
//  Chapter 24
//
//  Created by mrgsdev 12.05.2024.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
