//
//  IconCollectionViewController.swift
//  Chapter 35
//
//  Created by mrgsdev on 22.05.2024.
//

import UIKit
import IconDataKit

private let reuseIdentifier = "Cell"

class IconCollectionViewController: UICollectionViewController {

    enum Section {
        case all
    }
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
    lazy var dataSource = configureDataSource()
    
    private var iconSet: [Icon] = IconData.iconSet
    private var shareEnabled = false
    private var selectedIcons: [(icon: Icon, snapshot: UIImage)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        updateSnapshot()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 50, height: 100)
            layout.estimatedItemSize = .zero
            layout.minimumInteritemSpacing = 20
        }
    }

    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Icon> {

        let dataSource = UICollectionViewDiffableDataSource<Section, Icon>(collectionView: collectionView) { (collectionView, indexPath, icon) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
            cell.iconImageView.image = UIImage(named: icon.imageName)
            cell.iconPriceLabel.text = "$\(icon.price)"
            cell.backgroundView = (icon.isFeatured) ? UIImageView(image: UIImage(named: "feature-bg")) : nil
            
            let selectedBackground = UIView()
            selectedBackground.layer.borderColor = UIColor.systemRed.cgColor
            selectedBackground.layer.borderWidth = 3.0
            cell.selectedBackgroundView = selectedBackground
            
            return cell
        }

        return dataSource
    }

    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Icon>()
        snapshot.appendSections([.all])
        snapshot.appendItems(iconSet, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIconDetail" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as! IconDetailViewController
                destinationController.icon = iconSet[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showIconDetail" {
            if shareEnabled {
                return false
            }
        }
        
        return true
    }
    
    // MARK: - Action methods
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        guard shareEnabled else {
            // Change shareEnabled to YES and change the button text to Done
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true
            shareButton.title = "Done"
            shareButton.style = UIBarButtonItem.Style.plain
            
            return
        }
        
        // Make sure the user has selected at least one icon
        guard selectedIcons.count > 0 else {
            return
        }
        
        // Get the snapshots of the selected icons
        let snapshots = selectedIcons.map { $0.snapshot }
        
        // Create an activity view controller for sharing
        let activityController = UIActivityViewController(activityItems: snapshots, applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (activityType, completed, returnedItem, error) in
            
            // Deselect all selected items
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems {
                for indexPath in indexPaths  {
                    self.collectionView?.deselectItem(at: indexPath, animated: false)
                }
            }
            
            // Remove all items from selectedIcons array
            self.selectedIcons.removeAll(keepingCapacity: true)
            
            // Change the sharing mode to NO
            self.shareEnabled = false
            self.collectionView?.allowsMultipleSelection = false
            self.shareButton.title = "Share"
            self.shareButton.style = UIBarButtonItem.Style.plain
        }
        
        present(activityController, animated: true, completion: nil)
    }
}

extension IconCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Check if the sharing mode is enabled, otherwise, just leave this method
        guard shareEnabled else {
            return
        }
        
        // Determine the selected items by using the indexPath and take a snapshot
        if let selectedIcon = dataSource.itemIdentifier(for: indexPath) {
            if let snapshot = collectionView.cellForItem(at: indexPath)?.snapshot {
                // Add the selected item into the array
                selectedIcons.append((icon: selectedIcon, snapshot: snapshot))
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        // Check if the sharing mode is enabled, otherwise, just leave this method
        guard shareEnabled else {
            return
        }
        
        if let deSelectedIcon = dataSource.itemIdentifier(for: indexPath) {
        
            // Find the index of the deselected icon. Here we use the index method and pass it
            // a closure. In the closure, we compare the name of the deselected icon with all
            // the items in the selected icons array. If we find a match, the index method will
            // return us the index for later removal.
            if let index = selectedIcons.firstIndex(where: { $0.icon.name == deSelectedIcon.name }) {
                selectedIcons.remove(at: index)
            }
        }
    }
}
