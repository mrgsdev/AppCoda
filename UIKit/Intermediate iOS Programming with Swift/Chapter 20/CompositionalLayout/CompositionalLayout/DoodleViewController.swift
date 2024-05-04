//
//  DoodleViewController.swift
//  CompositionalLayout
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit

class DoodleViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var officeImages = (1...15).map { "office-\($0)" }
    private var kitchenImages = (1...25).map { "kitchen-\($0)" }
    private var macbookImages = (1...30).map { "macbook-\($0)" }
    
    lazy var dataSource = configureDataSource()
    
    enum Section: Int {
        case office
        case kitchen
        case macbook
        
        var columnCount: Int {
            switch self {
            case .office: return 1
            case .kitchen: return 2
            case .macbook: return 4
            }
        }
        
        var name: String {
            switch self {
            case .office: return "Office"
            case .kitchen: return "Kitchen"
            case .macbook: return "MacBook"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = createMultiGridLayout()
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "header")

        configureHeader()
        
        updateSnapshot()
        
    }

    // MARK: - Private Methods
    
    private func createGridLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(80.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20.0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    private func createMultiGridLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            var column = 1
            
            if let dataSection = Section(rawValue: sectionIndex) {
                column = dataSection.columnCount
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(column)),heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(sectionIndex == 0 ? 200 : 80.0))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            let section = NSCollectionLayoutSection(group: group)
            if sectionIndex == 0 {
                section.orthogonalScrollingBehavior = .continuous
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)

            section.boundarySupplementaryItems = [headerElement]
            
            return section
        }
        
        return layout
        
    }
}

// MARK: - Diffable Data Source

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
        snapshot.appendSections([.office, .kitchen, .macbook])
        snapshot.appendItems(officeImages, toSection: .office)
        snapshot.appendItems(kitchenImages, toSection: .kitchen)
        snapshot.appendItems(macbookImages, toSection: .macbook)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func configureHeader() {

        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            if kind == UICollectionView.elementKindSectionFooter {
                return nil
            }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "header", for: indexPath) as! SectionHeaderView
                
            headerView.titleLabel.text = section.name
                
            return headerView
        }
    }
}



