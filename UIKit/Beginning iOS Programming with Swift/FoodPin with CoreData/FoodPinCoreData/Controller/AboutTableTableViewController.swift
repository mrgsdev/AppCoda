//
//  AboutTableTableViewController.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit
import SafariServices
class AboutTableTableViewController: UITableViewController {
    
    enum Section {
        case feedback
        case followus
        case versionapp
    }
    struct LinkItem:Hashable {
        var text:String
        var link:String
        var image:String
    }
    var sectionContent = [
        [LinkItem(text: String(localized: "Rate us on App Store",comment: "Rate us on App Store"), link: "https://www.apple.com/ios/app-store/", image:"store")],
        [
            LinkItem(text: "GitHub", link: "https://github.com/mrgsdev", image: "github"),
            LinkItem(text: "Telegram", link: "https://t.me/mrgsdev", image: "telegram"),
        ],
        [LinkItem(text: "1.0", link: "", image: "")]
    ]
    lazy var dataSource = configureDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        updateSnapshot()
    }
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0: performSegue(withIdentifier: "showWebView", sender: self)
        case 1: openWithSafariViewController(indexPath: indexPath)
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func openWithSafariViewController(indexPath: IndexPath) {
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        if let url = URL(string: linkItem.link) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            if let destinationController = segue.destination as? WebViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let linkItem = self.dataSource.itemIdentifier(for: indexPath) {
                destinationController.targetURL = linkItem.link
            }
            
        }
    }
    
}
extension AboutTableTableViewController{
    // MARK: - Table view diffable data source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        let cellIdentifier = "aboutcell"
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView) { (tableView, indexPath, linkItem) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            return cell
        }
        return dataSource
    }
    func updateSnapshot() {
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func customNavBar(){
        //        navigationController?.navigationBar.prefersLargeTitles = true
        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
        }
    }
}
