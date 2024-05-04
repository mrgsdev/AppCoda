//
//  DoodleViewController.swift
//  UITraitCollection
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit

class DoodleViewController: UIViewController {
    
    enum Section {
        case all
    }
    
    private var doodleImages = (1...20).map { "DoodleIcons-\($0)" }
    lazy var dataSource = configureDataSource()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 128, height: 128)
            layout.estimatedItemSize = .zero
        }

        updateSnapshot()
    }

}

extension DoodleViewController {
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, String> {

        let dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView, indexPath, imageName) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DoodleCollectionViewCell
            cell.imageView.image = UIImage(named: imageName)
            
            return cell
        }

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(doodleImages, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sideSize = (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular) ? 80.0 : 128.0
        return CGSize(width: sideSize, height: sideSize)
    }
}
