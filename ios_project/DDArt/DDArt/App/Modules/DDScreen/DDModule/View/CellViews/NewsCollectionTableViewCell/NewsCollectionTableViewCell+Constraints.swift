//
//  NewsCollectionViewCell+Constraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

extension NewsCollectionTableViewCell {
    internal func addConstraintsCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
