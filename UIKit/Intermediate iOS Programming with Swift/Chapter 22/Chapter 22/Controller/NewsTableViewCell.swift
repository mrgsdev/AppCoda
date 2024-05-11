//
//  NewsTableViewCell.swift
//  Chapter 22
//
//  Created by mrgsdev on 11.05.2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var postImageView:UIImageView!
    @IBOutlet var authorImageView:UIImageView!
    @IBOutlet var postTitleLabel:UILabel!
    @IBOutlet var authorLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
