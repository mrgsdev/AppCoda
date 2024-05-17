//
//  TripViewController.swift
//  Chapter 30
//
//  Created by mrgsdev on 17.05.2024.
//


import UIKit
import Parse
class TripViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    lazy var dataSource = configureDataSource()
    
    enum Section {
        case all
    }
    
    private var trips = [Trip]()
    @IBAction func reloadButtonTapped(sender: Any) {
        loadTripsFromParse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = UIColor.clear
        loadTripsFromParse()
        updateSnapshot()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
}

// MARK: - Diffable Data Source

extension TripViewController {
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Trip> {
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Trip>(collectionView: collectionView) { (collectionView, indexPath, imageName) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TripCollectionViewCell
            cell.delegate = self
            
            if let trip = self.dataSource.itemIdentifier(for: indexPath) {
                cell.cityLabel.text = trip.city
                cell.countryLabel.text = trip.country
                cell.totalDaysLabel.text = "\(trip.totalDays) days"
                cell.priceLabel.text = "$\(String(trip.price))"
//              cell.imageView.image = trip.featuredImage
                // Load image in background
                cell.imageView.image = UIImage()
                if let featuredImage = trip.featuredImage {
                    featuredImage.getDataInBackground { (imageData, error) in
                        if let tripImageData = imageData {
                            cell.imageView.image = UIImage(data: tripImageData)
                        }
                    }
                
                }
            }
            
            // Add rounded corner
            cell.layer.cornerRadius = 10.0
            
            return cell
        }
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Trip>()
        snapshot.appendSections([.all])
        snapshot.appendItems(trips, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func loadTripsFromParse() {
        // Clear up the array
        trips.removeAll(keepingCapacity: true)
        // Pull data from Parse
        let query = PFQuery(className: "Trip")
//        query.cachePolicy = PFCachePolicy.networkElseCache // offline
        query.findObjectsInBackground { (objects, error) -> Void in
            if let error = error {
                print("Error: \(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects {
                objects.forEach { (object) in
                    // Convert PFObject into Trip object
                    let trip = Trip(pfObject: object)
                    self.trips.append(trip)
                }
            }
             
            self.updateSnapshot()
        }
    }
}



extension TripViewController: TripCollectionCellDelegate {
    func didTrashButtonPressed(cell: TripCollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        guard let selectedTrip = self.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        // Delete the trip
        trips[indexPath.row].toPFObject().deleteInBackground(block: { (success, error) -> Void in
            if (success) {
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems([selectedTrip])
                self.dataSource.apply(snapshot)
                
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

        })

    }
    
    
    func didLikeButtonPressed(cell: TripCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            trips[indexPath.row].isLiked = trips[indexPath.row].isLiked ? false : true
            cell.isLiked = trips[indexPath.row].isLiked
            
            // Update the trip on Parse
            trips[indexPath.row].toPFObject().saveInBackground(block: { (success, error) -> Void in
                if (success) {
                    print("Successfully updated the trip")
                } else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                }
            })
        }
    }
    
}



extension TripViewController: UIGestureRecognizerDelegate {
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        let point = gesture.location(in: self.collectionView)
        
        if (gesture.state == UIGestureRecognizer.State.ended) {
            if let indexPath = collectionView.indexPathForItem(at: point) {
                // Remove trip from Parse, array and collection view
                trips[indexPath.row].toPFObject().deleteInBackground(block: { (success, error) -> Void in
                    if (success) {
                        print("Successfully removed the trip")
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    self.trips.remove(at: indexPath.row)
                    
                })
            }
        }
    }
    
}
