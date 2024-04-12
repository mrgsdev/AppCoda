//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by mrgsdev on 12.04.2024.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    var restaurant:Restaurant = Restaurant()
    @IBOutlet var restaurantImageView: UIImageView! {
        didSet {
            restaurantImageView.image = UIImage(named: restaurant.image)
        }
    }
    @IBOutlet weak var stackView: UIStackView! {
        didSet{
            stackView.layer.cornerRadius = 20
            stackView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = restaurant.name
        }
    }
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            locationLabel.text = restaurant.location
        }
    }
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            typeLabel.text = restaurant.type
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
