//
//  CategoryFoodCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//

import UIKit

class CategoryFoodCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: CategoryFoodCell.self)

    internal var nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(nameLabel)
        addConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpLabel()
    }

    private func setUpLabel() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 12)
        nameLabel.textColor = .black
        nameLabel.text = "Обычные данные"
    }

    func configure(model: FoodCategory, complition: @escaping () -> (Bool)) {

        guard !model.photos.isEmpty else {return}
        nameLabel.text = model.name
            }
}

extension CategoryFoodCell {
    func addConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
}
