//
//  FoodCategoriesCollectionViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit

final class FoodCategoriesCollectionViewCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var array: [FoodCategory] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: SizeConstants.screenHeight/5, height: SizeConstants.screenHeight/5-5)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    static let cellIdentifier = String(describing: FoodCategoriesCollectionViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [collectionView].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsCollectionView()
        setUp()
    }
    
    override func updateViews() {
        guard let model = model as? FoodCategoriesCollectionViewModel else { return }
        array = model.array
        collectionView.reloadData()
    }
    
    private func setUp() {
        backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FoodCategoriesViewCell.self, forCellWithReuseIdentifier: FoodCategoriesViewCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoriesViewCell.cellIdentifier, for: indexPath)
                as? FoodCategoriesViewCell else {
                    return UICollectionViewCell()
                }
        
        cell.configure(model: array[indexPath.row]) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model as? FoodCategoriesCollectionViewModel else { return }
        model.action?(indexPath.row)
    }
}