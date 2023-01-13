//
//  FoodCategoriesCollectionViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
final class FoodCategoriesCollectionViewModel: CellIdentifiable {
    var cellHeight: Float {
        return Float(SizeConstants.screenHeight/5)
    }
    
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?
    
    var cellIdentifier: String {
        return FoodCategoriesCollectionViewCell.cellIdentifier
    }
    
    let array: [FoodCategory]
    
    init(array: [FoodCategory], action: ActionHandler? = nil) {
        self.action = action
        self.array = array
    }
}
