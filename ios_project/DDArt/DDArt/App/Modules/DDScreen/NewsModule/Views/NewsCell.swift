//
//  NewsCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell {
    static let cellIdentifier = String(describing: NewsCell.self)
    var delegate: NewsCell?
    internal var newsImage = UIImageView()
    internal var nameLabel = UILabel()
    internal var titleLabel = UILabel()
    internal var stackView = UIStackView()
    
    internal var image: UIImage?
    var id: UUID?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addConstraints()
    }
    
    private func setUp() {
        setUpLabels()
        setUpImage()
        setUpStack()
    }
    
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 36)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        titleLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
    }
    
    private func setUpImage() {
        contentView.backgroundColor = UIColor.white
        newsImage.clipsToBounds = true
        layer.masksToBounds = true
        self.clipsToBounds = true
        newsImage.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 20
        newsImage.layer.cornerRadius = 5
        self.contentView.addSubview(newsImage)
    }
    private func setUpStack() {
        stackView.axis = .vertical
        stackView.addArrangedSubview(CreateStack.createStack(
            distribution: .fillEqually,
            alignmentStack: .center, spacing: 0,
            views: nameLabel, titleLabel)
        )
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 20
        self.newsImage.addSubview(stackView)
    }
    func configure(model: NewsModel, complition: @escaping () -> (Bool)) {
        self.newsImage.image = image ?? UIImage(named: "noData")
        nameLabel.attributedText = model.newsName.underLined
        titleLabel.text = model.titleNews
        self.id = model.id
        guard !model.photos.isEmpty else {return}
        if image == nil {
            DispatchQueue.global().async {
                ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures") { image in
                    DispatchQueue.main.async {
                        if !complition() { return }
                        self.image = image
                        self.newsImage.image = image
                    }
                }
            }
        }
    }
}

extension NewsCell {
    internal func addConstraints() {
        self.newsImage
            .translatesAutoresizingMaskIntoConstraints = false
        self.newsImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.newsImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.newsImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.newsImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.centerXAnchor.constraint(equalTo: self.newsImage.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.newsImage.centerYAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width/1.5).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/2).isActive = true
    }
}
