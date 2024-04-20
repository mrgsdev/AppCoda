//
//  ArticleTableViewController.swift
//  Chapter 3
//
//  Created by mrgsdev on 20.04.2024.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    enum Section {
        case all
    }
    
    let articles = [ Article(title: "Use Background Transfer Service To Download File in Background", image: "imessage-sticker-pack"),
                     Article(title: "Face Detection in iOS Using Core Image", image: "face-detection-featured"),
                     Article(title: "Building a Speech-to-Text App Using Speech Framework in iOS", image: "speech-kit-featured"),
                     Article(title: "Building Your First Web App in Swift Using Vapor", image: "vapor-web-framework"),
                     Article(title: "Creating Gradient Colors Using CAGradientLayer", image: "cagradientlayer-demo"),
                     Article(title: "A Beginner's Guide to CALayer", image: "calayer-featured")
    ]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSnapshot()
        
        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }

    // MARK: - Table view data source

    func configureDataSource() -> UITableViewDiffableDataSource<Section, Article> {

        let cellIdentifier = "Cell"

        let dataSource = UITableViewDiffableDataSource<Section, Article>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, article in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell

                cell.titleLabel.text = article.title
                cell.postImageView.image = UIImage(named: article.image)

                return cell
            }
        )

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.all])
        snapshot.appendItems(articles, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
}
