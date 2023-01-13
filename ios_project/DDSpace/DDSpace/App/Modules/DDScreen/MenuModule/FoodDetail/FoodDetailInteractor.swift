//
//  FoodDetailInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class FoodDetailInteractor {
    weak var output: FoodDetailInteractorOutput?
}

extension FoodDetailInteractor: FoodDetailInteractorInput {
    func updateFood(food: FoodSaveModel) {
        CoreDataService.shared.update(with: food)
    }
    
    func addToCoreData(food: FoodSaveModel) {
        CoreDataService.shared.insert(with: food)
    }
    
    func deleteFromCoreData(id: String) {
        CoreDataService.shared.delete(with: id)
    }
    
    func getFoodCountInCart(id: String) -> Int {
        CoreDataService.shared.fetchCountCart(with: id)
    }
    
    
    
}
