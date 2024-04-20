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
    let articles = [
        Article(title: "Use Background Transfer Service To Download File in Background", image:"imessage-sticker-pack"),
        Article(title: "Face Detection in iOS Using Core Image", image: "face-detection-featured"),
        Article(title: "Building a Speech-to-Text App Using Speech Framework in iOS", image: "speech-kit-featured"),
        Article(title: "Building Your First Web App in Swift Using Vapor", image: "vapor-web-framework"),
        Article(title: "Creating Gradient Colors Using CAGradientLayer", image: "cagradientlayer-demo"),
        Article(title: "A Beginner's Guide to CALayer", image: "calayer-featured")
    ]
    
    lazy var dataSource = configureDataSource()
    
    
   
    lazy var articleShown = [Bool](repeating: false, count: articles.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSnapshot()
        
        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
extension ArticleTableViewController{
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Determine if the post is displayed. If yes, we just return and no animation will be created
        if articleShown[indexPath.row] {
            return
        }
        
        // Indicate the post has been displayed, so the animation won't be displayed again
        articleShown[indexPath.row] = true
        
        // Define the initial state (Before the animation)
        let rotationAngleInRadians = 90.0 * CGFloat(Double.pi/180.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        cell.layer.transform = rotationTransform
        
        // Define the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
}
