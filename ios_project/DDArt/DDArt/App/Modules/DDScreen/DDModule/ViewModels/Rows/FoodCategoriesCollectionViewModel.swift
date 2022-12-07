//
//  FoodCategoriesCollectionViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
final class FoodCategoriesCollectionViewModel: CellIdentifiable {
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    var cellIdentifier: String {
        return FoodCategoryViewModel.cellIdentifier
    }

    let array: [FoodCategory]

    init(array: [FoodCategory], action: ActionHandler? = nil) {
        self.action = action
        self.array = array
    }
}
