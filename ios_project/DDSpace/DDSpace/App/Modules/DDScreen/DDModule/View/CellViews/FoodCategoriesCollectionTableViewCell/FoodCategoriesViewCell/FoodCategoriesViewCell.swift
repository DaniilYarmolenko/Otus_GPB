//
//  FoodCategoriesViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit
final class FoodCategoriesViewCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: FoodCategoriesViewCell.self)

    internal var imageView = UIImageView()
    internal var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.addSubview(nameLabel)
        addConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpImageView()
        setUpLabel()
    }

    private func setUpLabel() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 30)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
    }
    private func setUpImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
    }

    func configure(model: FoodCategory, complition: @escaping () -> (Bool)) {
        self.nameLabel.attributedText = model.name.underLined
    }
}
