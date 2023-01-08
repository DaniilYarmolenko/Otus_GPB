//
//  CategoryFoodCollection.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//

import Foundation

import Foundation
import UIKit

final class CategoryFoodCollectionAdapter: NSObject {
    
    var categoryFoodModel: [FoodCategory]
    
    init(categoryFood: [FoodCategory]) {
        self.categoryFoodModel = categoryFood
    }
    
    
    func setup(for collectionView: UICollectionView){
        collectionView.register(CategoryFoodCell.self, forCellWithReuseIdentifier: FoodCategoriesViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
}


extension CategoryFoodCollectionAdapter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryFoodModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFoodCell.cellIdentifier, for: indexPath)
                as? CategoryFoodCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: categoryFoodModel[indexPath.row]) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    
    
}
