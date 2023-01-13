//
//  FoodCartInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class FoodCartInteractor {
    weak var output: FoodCartInteractorOutput?
    var total: Int = 0
}

extension FoodCartInteractor: FoodCartInteractorInput {
    var totalAmount: Int {
        get {
            total
        }
        set {
            total = newValue
        }
    }
    
    func getCoreDataItems() {
        let coreDataItems = CoreDataService.shared.fetchAll()
        var allCount = 0
        totalAmount = 0
        let models = coreDataItems.map { data in
            allCount += Int(data.count)
            totalAmount += Int(data.count)*Int(data.cost)
            let model = FoodSaveModel(id: data.id, nameFood: data.name, data: data.data, count: Int(data.count), cost: Int(data.cost))
            return model
        }
        output?.receiveCoreDataItems(foods: models)
        UserDefaults.standard.set(allCount, forKey: "countCart")
        NotificationCenter.default.post(name: NSNotification.Name("cartBadge"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("detailFoodBadge"), object: nil)
    }
    
    func deleteBy(with id: String) {
        CoreDataService.shared.delete(with: id)
        getCoreDataItems()
    }
    
    func deleteAll() {
        CoreDataService.shared.deleteAll()
        getCoreDataItems()
    }
    
    func countUpdate(food: FoodSaveModel) {
        CoreDataService.shared.update(with: food)
        getCoreDataItems()
    }
    
}
