//
//  MainCell.swift
//  TableView_Homework
//
//  Created by Даниил Ярмоленко on 17.10.2022.
//

import UIKit

class MainCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIView()
    
    lazy var cityImageView: UIImageView = {
        cityImageView = UIImageView()
        cityImageView.contentMode = .scaleToFill
        cityImageView.backgroundColor = .black
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 10
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return cityImageView
    }()
    
    
    lazy var nameCityLong: UILabel = {
        nameCityLong = UILabel(frame: .zero)
        nameCityLong.font = UIFont(name: "Kurale-Regular", size: 18)
        nameCityLong.textColor = .black
        nameCityLong.numberOfLines = 0
        nameCityLong.translatesAutoresizingMaskIntoConstraints = false
        
        return nameCityLong
    }()
    
    lazy var descriptionCity: UILabel = {
        descriptionCity = UILabel()
        descriptionCity.font = UIFont(name: "Kurale-Regular", size: 16)
        descriptionCity.numberOfLines = 2
        descriptionCity.textColor = .black
        descriptionCity.translatesAutoresizingMaskIntoConstraints = false
        return descriptionCity
    }()
    
    lazy var countryName: UILabel = {
        countryName = UILabel(frame: .zero)
        countryName.font = UIFont(name: "SF-Pro-Rounded-Regular", size: 13)
        countryName.textColor = .systemGray
        countryName.translatesAutoresizingMaskIntoConstraints = false
        return countryName
    }()
    
    private func setupLayoutCell(){
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            cityImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .padding),
            cityImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cityImageView.heightAnchor.constraint(equalToConstant: 70),
            cityImageView.widthAnchor.constraint(equalToConstant: 70),
            
            nameCityLong.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            nameCityLong.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: .padding),
            
            countryName.topAnchor.constraint(equalTo: nameCityLong.topAnchor),
            countryName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionCity.leadingAnchor.constraint(equalTo: nameCityLong.leadingAnchor),
            descriptionCity.topAnchor.constraint(equalTo: nameCityLong.bottomAnchor, constant: 2),
            descriptionCity.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            

        ])
    }
    private func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 1.5
        containerView.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        containerView.layer.shadowOpacity = 0.8
        containerView.backgroundColor = .white
        
        [cityImageView, nameCityLong, countryName, descriptionCity].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayoutCell()
        let margins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
                contentView.frame = contentView.frame.inset(by: margins)
    }

}

private extension CGFloat {
    static let padding: CGFloat = 16
}
