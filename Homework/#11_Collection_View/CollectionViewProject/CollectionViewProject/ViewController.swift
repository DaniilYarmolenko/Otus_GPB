//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Даниил Ярмоленко on 18.10.2022.
//

import UIKit

class ViewController: CollectionVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World City"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        setupLayoutWithCollection()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: .colId)
        // Do any additional setup after loading the view.
    }
    
    private func setupLayoutWithCollection(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = dataFromModel[indexPath.row]
        let vc = DetailVC()
        vc.countryName.text = data.countryName
        vc.descriptionCity.text = data.description
        vc.nameCityLong.text = data.cityNameLong
        vc.cityImageView.image = UIImage(named: data.photo ?? "noPhoto")
        navigationController?.pushViewController(vc, animated: true)
    }
}

