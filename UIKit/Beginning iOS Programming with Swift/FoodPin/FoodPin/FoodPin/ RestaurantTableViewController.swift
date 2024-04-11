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
    
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
        "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery",
        "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif",
        "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore",
        "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"
    ]
    var restaurantImages = [
        "cafedeadend", "homei", "teakha", "cafeloisl",
        "petiteoyster", "forkee", "posatelier", "bourkestreetbakery",
        "haigh", "palomino", "upstate", "traif",
        "graham", "waffleandwolf", "fiveleaves", "cafelore",
        "confessional", "barrafina", "donostia", "royaloak", "cask"
    ]
     
    var restaurantLocations = [
        "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
        "Sydney", "Sydney", "Sydney",
        "New York", "New York", "New York", "New York", "New York", "New York", "New York",
        "London", "London", "London", "London"
    ]
                               
    var restaurantTypes = [
        "Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French",
        "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American",
        "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea",
        "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"
    ]
    
    lazy var dataSourse = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true // iPad
        tableView.separatorStyle = .none
        tableView.dataSource = dataSourse
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSourse.apply(snapshot)
        
        
    }
    
    // MARK: - Table view data source

    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView) { tableView, indexPath, restaurantName in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            
            cell.nameLabel?.text = restaurantName
            cell.locationLabel.text = self.restaurantLocations[indexPath.row]
            cell.typeLabel.text = self.restaurantTypes[indexPath.row]
            cell.thumbnailImageView?.image = UIImage(named: self.restaurantImages[indexPath.row])
            cell.favouriteImage.isHidden = self.restaurantIsFavorites[indexPath.row] ?  false : true
            return cell
            
        }
        return dataSource
    }
}

 
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
