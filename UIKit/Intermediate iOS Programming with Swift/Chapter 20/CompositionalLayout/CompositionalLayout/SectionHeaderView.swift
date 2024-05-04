//
//  SectionHeaderView.swift
//  CompositionalLayout
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    var titleLabel: UILabel = {
         let label = UILabel()
         
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.preferredFont(forTextStyle: .headline)
         
         return label
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         addSubview(titleLabel)
         
         NSLayoutConstraint.activate([
             titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
             titleLabel.leadingAnchor.constraint(equalTo: titleLabel.superview!.layoutMarginsGuide.leadingAnchor, constant: 20)
         ])
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
