//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by mrgsdev on 10.04.2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    enum Section {
        case all
    }
    var restaurants = [
        
        Restaurant(name: "Cafe Deadend",
                   type: "Coffee & Tea Shop",
                   location: "Hong Kong",
                   image: "cafedeadend"
                  ),
        Restaurant(name: "Homei",
                   type: "Cafe",
                   location: "Hong Kong",
                   image: "homei"
                  ),
        Restaurant(name: "Teakha", 
                   type: "Tea House",
                   location: "Hong Kong",
                   image: "teakha"
                  ),
        Restaurant(name: "Cafe loisl", 
                   type: "Austrian / Causual Drink",
                   location: "Hong Kong",
                   image: "cafeloisl"
                  ),
        Restaurant(name: "Petite Oyster", 
                   type: "French",
                   location: "Hong Kong",
                   image: "petiteoyster"
                  ),
        Restaurant(name: "For Kee Restaurant", 
                   type: "Bakery",
                   location: "Hong Kong",
                   image: "forkee"
                  ),
        Restaurant(name: "Po's Atelier",
                   type: "Bakery",
                   location: "Hong Kong",
                   image: "posatelier"
                  ),
        Restaurant(name: "Bourke Street Backery",
                   type: "Chocolate",
                   location: "Sydney",
                   image: "bourkestreetbakery"
                  ),
        Restaurant(name: "Haigh's Chocolate", 
                   type: "Cafe",
                   location: "Sydney",
                   image: "haigh"
                  ),
        Restaurant(name: "Palomino Espresso", 
                   type: "American / Seafood",
                   location: "Sydney",
                   image: "palomino"
                  ),
        Restaurant(name: "Upstate", 
                   type: "American", 
                   location: "New York",
                   image: "upstate"
                  ),
        Restaurant(name: "Traif",
                   type: "American", 
                   location: "New York",
                   image: "traif"
                  ),
        Restaurant(name: "Graham Avenue Meats",
                   type: "Breakfast & Brunch",
                   location: "New York",
                   image: "graham"
                  ),
        Restaurant(name: "Waffle & Wolf", 
                   type: "Coffee & Tea", 
                   location: "New York", 
                   image: "waffleandwolf"
                  ),
        Restaurant(name: "Five Leaves",
                   type: "Coffee & Tea", 
                   location: "New York", 
                   image: "fiveleaves"
                  ),
        Restaurant(name: "Cafe Lore",
                   type: "Latin American", 
                   location: "New York", 
                   image: "cafelore"
                  ),
        Restaurant(name: "Confessional",
                   type: "Spanish", 
                   location: "New York", 
                   image: "confessional"
                  ),
        Restaurant(name: "Barrafina",
                   type: "Spanish", 
                   location: "London",
                   image: "barrafina"
                  ),
        Restaurant(name: "Donostia",
                   type: "Spanish", 
                   location: "London",
                   image: "donostia"
                  ),
        Restaurant(name: "Royal Oak",
                   type: "British", 
                   location: "London",
                   image: "royaloak"
                  ),
        Restaurant(name: "CASK Pub and Kitchen",
                   type: "Thai", 
                   location: "London", 
                   image: "cask"
                  )
    ]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UITableView Diffable Data Source

    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(tableView: tableView) { tableView, indexPath, restaurant in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            
            cell.nameLabel?.text = restaurant.name
            cell.locationLabel.text = restaurant.location
            cell.typeLabel.text = restaurant.type
            cell.thumbnailImageView?.image = UIImage(named: restaurant.image)
            cell.favouriteImage.isHidden = self.restaurantIsFavorites[indexPath.row] ?  false : true
            return cell
            
        }
        return dataSource
    }
}

// MARK: - UITableViewDelegate Protocol
extension RestaurantTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteActionTitle = self.restaurantIsFavorites[indexPath.row] ? "Remove from favorites" : "Mark as favorite"
         
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default) { _ in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            cell.favouriteImage.isHidden = self.restaurantIsFavorites[indexPath.row]
            
            self.restaurantIsFavorites[indexPath.row] = self.restaurantIsFavorites[indexPath.row] ? false : true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
         
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default) { _ in
            
            let alertMessage = UIAlertController(
                title: "Not available yet",
                message: "Sorry, this feature is not available yet. Please retry later.",
                preferredStyle: .alert
            )
            
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(reserveAction)
        //iPad Alert
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
