//
//  DoodleCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit

class DoodleCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 20.0
            imageView.clipsToBounds = true
        }
    }
}
