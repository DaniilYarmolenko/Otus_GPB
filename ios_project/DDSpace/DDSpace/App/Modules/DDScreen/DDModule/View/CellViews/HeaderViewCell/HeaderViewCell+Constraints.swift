//
//  HeaderViewCell+Constraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import UIKit

extension HeaderCellView {
     func addConstraintsHeader() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
         titleLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
         
         moreButton.translatesAutoresizingMaskIntoConstraints = false
         moreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
         moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
         moreButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
