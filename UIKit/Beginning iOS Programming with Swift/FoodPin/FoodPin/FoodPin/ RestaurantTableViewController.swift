//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by mrgsdev on 10.04.2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
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
    lazy var dataSourse = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.textLabel?.text = restaurantName
            cell.imageView?.image = UIImage(named: self.restaurantImages[indexPath.row])
            return cell
            
        }
        return dataSource
    }
}

 
