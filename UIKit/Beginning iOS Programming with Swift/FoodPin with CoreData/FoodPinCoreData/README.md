
## Custom NavigationController

<img width="299" alt="Снимок экрана 2022-06-16 в 14 03 09" src="https://user-images.githubusercontent.com/107209053/174056632-b3dada6c-8f78-406e-b69e-1c3a117fdde4.png">

``` swift
    func customNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        if let appearance = navigationController?.navigationBar.standardAppearance
        {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
``` 
## UITableViewDiffableDataSource
``` swift
    func configureDataSource() -> RestaurantDiffableDataSource {
        let cellID = "datacell"
        
        let dataSource = RestaurantDiffableDataSource (tableView: tableView) { tableView, indexPath, restaurant in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel?.text = restaurant.name // restaruntname
            cell.locationLabel.text = self.restaurants[indexPath.row].location
            cell.typeLabel.text = self.restaurants[indexPath.row].type
            cell.thumbnailImageView?.image = UIImage(named: restaurant.image)
            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite ? false : true
            return cell
        }
        return dataSource
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false,completion: nil)
    }
``` 
``` swift
enum Section {
    case all
}
class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
    }
}
```
 ## UISearch 
 ``` swift
  func customSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
 // or 👇
 //     tableView.tableHeaderView = searchController.searchBar 
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
    }
 ``` 
## Localization language

<img width="654" alt="1" src="https://user-images.githubusercontent.com/107209053/174827988-c88e6d40-6add-4bd0-8d37-d7239ec5ba44.png">
Export
<img width="255" alt="2" src="https://user-images.githubusercontent.com/107209053/174827999-5cbb2c3e-e529-402a-ae16-7c08c08006af.png">
<img width="795" alt="3" src="https://user-images.githubusercontent.com/107209053/174828002-f7547dd8-fd0d-4c36-8b28-cc03d4b0a2f0.png">
