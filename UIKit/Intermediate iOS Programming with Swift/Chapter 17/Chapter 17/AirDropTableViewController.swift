//
//  AirDropTableViewController.swift
//  Chapter 17
//
//  Created by mrgsdev on 05.05.2024.
//

import UIKit
 
class AirDropTableViewController: UITableViewController {

    let filenames = ["10 Great iPhone Tips.pdf", "camera-photo-tips.html", "foggy.jpg", "Hello World.ppt", "glico.jpg", "Why Appcoda.doc"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return filenames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row)");


        return cell
    }
    
    // MARK: - Segues
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFileDetail" {
            let destinationController = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationController.filename = filenames[indexPath.row]
            }
        }
    }


}
