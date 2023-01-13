//
//  CategoriesSearchCollectionCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
import UIKit

final class CategoriesSearchCollectionCell: UICollectionViewCell {
    weak var delegate: EventsSearchViewOutput?
    static let cellIdentifier = String(describing: CategoriesSearchCollectionCell.self)
    internal var imageView = UIImageView()
    internal var nameCategory = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.addSubview(nameCategory)
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
    
    private func setUpImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
    }
    
    private func setUpLabel() {
        nameCategory.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 30)
        nameCategory.textAlignment = .center
        nameCategory.textColor = .white
        nameCategory.layer.cornerRadius = 10
        nameCategory.layer.masksToBounds = true
        nameCategory.backgroundColor = .black
        imageView.addSubview(nameCategory)
    }
    
    func configure(model: CategoryModel, complition: @escaping () -> (Bool)) {
        self.imageView.image = UIImage(named: "category")
        nameCategory.attributedText = model.name.underLined
        guard !model.photos.isEmpty else {return}
        DispatchQueue.global().async {
            ImageLoader.shared.image(with: model.photos[0], folder: "CategoriesPictures") { image in
                DispatchQueue.main.async {
                    if !complition() { return }
                    self.imageView.image = image
                }
            }
        }
    }
    
}

extension CategoriesSearchCollectionCell {
    internal func addConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.nameCategory.translatesAutoresizingMaskIntoConstraints = false
        self.nameCategory.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.nameCategory.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.nameCategory.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width - 20).isActive = true
        self.nameCategory.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/4).isActive = true
    }
}
