//
//  NewsViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit
final class NewsCollectionCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: NewsCollectionCell.self)

    internal var imageView = UIImageView()
    private var image: UIImage?
    private var imageName: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        addConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpImageView()
    }

    private func setUpImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
//        contentView.clipsToBounds = true
    }

    func configure(model: NewsModel, complition: @escaping () -> (Bool)) {
            
        }
}
