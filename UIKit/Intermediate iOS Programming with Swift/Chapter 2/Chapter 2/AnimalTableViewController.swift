//
//  TableViewController.swift
//  Chapter 2
//
//  Created by mrgsdev on 19.04.2024.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate data
        tableView.dataSource = dataSource
        createAnimalDict()
        updateSnapshot()
    }
    
    private func createAnimalDict() {
        for animal in animals {
            // Get the first letter of the animal name and build the dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
            
        }
        // Get the section titles from the dictionary's keys and sort them in ascendin g order
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles = animalSectionTitles.sorted(by: { $0 < $1 })
    }
}

extension AnimalTableViewController {
    
    func configureDataSource() -> AnimalTableDataSource {
        
        let dataSource = AnimalTableDataSource(tableView: tableView) { (tableView, indexPath, animalName) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = animalName
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFileName = animalName.lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
            
            
            return cell
        }
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(animalSectionTitles)
        animalSectionTitles.forEach { (section) in
            if let animals = animalsDict[section] {
                snapshot.appendItems(animals, toSection: section)
            }
            
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension AnimalTableViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236, green: 240, blue: 241)
        headerView.textLabel?.textColor = UIColor(red: 231, green: 76, blue: 60)
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
        
    }
}


extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
    }
     
}
