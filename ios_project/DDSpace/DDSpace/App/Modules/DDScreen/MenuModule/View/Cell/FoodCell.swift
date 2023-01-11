//
//  FoodCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//
//var nameFood: String
//var description: String
//var photos: [String]
//var cost: Int
import Foundation
import UIKit

final class FoodCell: UICollectionViewCell {
    weak var delegate: MenuViewOutput?
    static let cellIdentifier = String(describing: CategoriesSearchCollectionCell.self)
    internal var imageView = UIImageView()
    internal var nameFoodLabel = UILabel()
    internal var stackLabels = UIStackView()
    internal var costLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        setUp()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpLabel()
        setUpImageView()
    }

    private func setUpImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        self.contentView.addSubview(imageView)
    }
    
    private func setUpLabel() {
        nameFoodLabel.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 30)
        nameFoodLabel.textColor = .white
        costLabel.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 20)
        costLabel.textColor = .white
        stackLabels.addArrangedSubview(CreateStack.createStack(axis: .vertical, alignmentStack: .center, spacing: 4, views: nameFoodLabel, costLabel))
        self.contentView.addSubview(stackLabels)
    }
    
    func configure(model: FoodModel, complition: @escaping () -> (Bool)) {
        nameFoodLabel.attributedText = model.nameFood.underLined
        costLabel.text = "\(model.cost)₽"
    }
    
}

extension FoodCell {
    internal func addConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height - 50).isActive = true
        
        self.stackLabels.translatesAutoresizingMaskIntoConstraints = false
        self.stackLabels.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5).isActive = true
        self.stackLabels.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.stackLabels.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.stackLabels.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
//        self.nameCategory.translatesAutoresizingMaskIntoConstraints = false
//        self.nameCategory.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
//        self.nameCategory.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
//        self.nameCategory.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width/2).isActive = true
//        self.nameCategory.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/2).isActive = true
    }
}
