//
//  FoodCategoriesViewCell+Constraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
extension FoodCategoriesViewCell {
    internal func addConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).isActive = true
        self.nameLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        self.nameLabel.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, constant: -30).isActive = true
        self.nameLabel.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, constant: -30).isActive = true

    }
}
