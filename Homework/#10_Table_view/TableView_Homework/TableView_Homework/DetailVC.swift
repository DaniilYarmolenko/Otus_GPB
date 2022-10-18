//
//  DetailVC.swift
//  TableView_Homework
//
//  Created by Даниил Ярмоленко on 17.10.2022.
//

import UIKit

class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayoutView()
        // Do any additional setup after loading the view.
    }
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
        descriptionCity.font = UIFont(name: "Kurale-Regular", size: UIFont.labelFontSize)
        descriptionCity.numberOfLines = 0
        descriptionCity.textColor = .black
        descriptionCity.translatesAutoresizingMaskIntoConstraints = false
        descriptionCity.textAlignment = .center
        return descriptionCity
    }()
    
    lazy var countryName: UILabel = {
        countryName = UILabel(frame: .zero)
        countryName.font = UIFont(name: "SF-Pro-Rounded-Regular", size: 13)
        countryName.textColor = .systemGray
        countryName.translatesAutoresizingMaskIntoConstraints = false
        return countryName
    }()
    
    
    private func setupLayoutView(){
        [cityImageView, nameCityLong, countryName, descriptionCity].forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            cityImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            cityImageView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            cityImageView.widthAnchor.constraint(equalToConstant: view.frame.width/1.8),
            
            nameCityLong.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 8),
            nameCityLong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            countryName.topAnchor.constraint(equalTo: nameCityLong.bottomAnchor, constant: 4),
            countryName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionCity.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 8),
            descriptionCity.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionCity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    
        ])
    }

}
