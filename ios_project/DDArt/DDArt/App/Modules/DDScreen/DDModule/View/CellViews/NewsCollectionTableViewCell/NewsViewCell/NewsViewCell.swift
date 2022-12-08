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
        self.imageView.image = UIImage(named: "noData")
        guard !model.photos.isEmpty else {return}
        DispatchQueue.global().async {
            ImageLoader.shared.image(with: model.photos[0]) { image in
                DispatchQueue.main.async {
                    if !complition() { return }
                    self.imageView.image = image
                }
            }
        }
    }
}
