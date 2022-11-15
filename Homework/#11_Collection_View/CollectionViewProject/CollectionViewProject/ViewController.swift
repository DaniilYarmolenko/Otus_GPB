//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Даниил Ярмоленко on 18.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionAdapter = CollectionAdapter(navigationController: navigationController)
    
    
    lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: customFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var customFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 40
        layout.itemSize = CGSize(width: view.bounds.width/2, height: view.bounds.height/2.8)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World City"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionAdapter.setup(for: collectionView)
        view.addSubview(collectionView)
        setupLayoutWithCollection()
    }
    
    private func setupLayoutWithCollection(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

