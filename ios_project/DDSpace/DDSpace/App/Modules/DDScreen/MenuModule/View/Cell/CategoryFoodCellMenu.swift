//
//  CategoryFoodCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.01.2023.
//

import Foundation
import UIKit

final class CategoryFoodMenuCell: UICollectionViewCell {
    var delegate: MenuViewOutput?
    static let cellIdentifier = String(describing: CategoryFoodMenuCell.self)
    internal var nameCategory = UILabel()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setUp()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpLabel()
    }

    
    private func setUpLabel() {
        nameCategory.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 30)
        nameCategory.textColor = .black
        nameCategory.textAlignment = .center
        self.contentView.addSubview(nameCategory)
    }
    
    func configure(name: String, complition: @escaping () -> (Bool)) {
        nameCategory.attributedText = name.underLined
    }
    
}

extension CategoryFoodMenuCell {
    internal func addConstraints() {
        self.nameCategory.translatesAutoresizingMaskIntoConstraints = false
        self.nameCategory.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.nameCategory.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.nameCategory.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.nameCategory.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
