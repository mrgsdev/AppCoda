//
//  MenuTableViewController.swift
//  Chapter 31
//
//  Created by mrgsdev on 18.05.2024.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {

    private var menuItems:[MenuItem] = []
    var fetchResultController: NSFetchedResultsController<MenuItem>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load menu items from database
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                menuItems = try context.fetch(request)
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        // Make the cell self size
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell

        // Configure the cell...
        cell.nameLabel.text = menuItems[indexPath.row].name
        cell.detailLabel.text = menuItems[indexPath.row].detail
        cell.priceLabel.text = "$\(menuItems[indexPath.row].price)"

        return cell
    }
    

}
