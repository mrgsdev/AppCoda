//
//  RouteTableViewController.swift
//  Chapter 8
//
//  Created by mrgsdev on 25.04.2024.
//

import UIKit
import MapKit
class RouteTableViewController: UITableViewController {
    var routeSteps = [MKRoute.Step]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return routeSteps.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = routeSteps[indexPath.row].instructions

        return cell
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
