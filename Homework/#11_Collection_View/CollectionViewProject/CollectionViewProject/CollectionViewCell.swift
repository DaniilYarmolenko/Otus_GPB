//
//  CollectionViewCell.swift
//  CollectionViewProject
//
//  Created by Даниил Ярмоленко on 18.10.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let containerView = UIView()
    
    lazy var cityImage: UIImageView = {
        cityImage = UIImageView()
        cityImage.contentMode = .scaleAspectFill
        cityImage.layer.borderWidth = 4
        cityImage.layer.borderColor = UIColor.white.cgColor
        cityImage.backgroundColor = .white
        cityImage.clipsToBounds = true
        cityImage.layer.cornerRadius = 20
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        return cityImage
    }()

    
    lazy var cityLongName: UILabel = {
        cityLongName = UILabel(frame: .zero)
        cityLongName.font = UIFont(name: "SF-Pro-Rounded-Regular", size: 16)
        cityLongName.textColor = .black
        cityLongName.translatesAutoresizingMaskIntoConstraints = false
        
        return cityLongName
    }()
    
    lazy var countryName: UILabel = {
        countryName = UILabel(frame: .zero)
        countryName.font = UIFont(name: "Kurale-Regular", size: 14)
        countryName.textAlignment = .center
        countryName.textColor = .systemGray
        countryName.translatesAutoresizingMaskIntoConstraints = false
        
        return countryName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
    }
    
    override func layoutSubviews() {
        setupLayoutCell()
    }
    
    private func setupLayoutCell(){
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            cityImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cityImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            cityImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cityImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            
            cityLongName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cityLongName.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 4),
            
            countryName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            countryName.topAnchor.constraint(equalTo: cityLongName.bottomAnchor, constant: 2),
        ])
    }
    
    private func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = .white
        
        
        [cityImage, cityLongName, countryName].forEach {
            containerView.addSubview($0)
        }
        
        contentView.addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
