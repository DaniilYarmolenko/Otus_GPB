//
//  MenuInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import Foundation

final class MenuInteractor {
    weak var output: MenuInteractorOutput?
    private let group = DispatchGroup()
    private let dispatchQueue = DispatchQueue(label: "loadData")
    private let dispatchSemaphore = DispatchSemaphore(value: 0)
    var foods = [FoodModel]()
}

extension MenuInteractor: MenuInteractorInput {
    func countCart() -> Int {
        let coreDataItems = CoreDataService.shared.fetchAll()
        var count = 0
        coreDataItems.forEach { cart in
            count += Int(cart.count)
        }
        return count
    }
    
    func loadData(categories: [FoodCategory]) {
        dispatchQueue.async {
            categories.forEach { category in
                self.group.enter()
                ApiService<FoodModel>(resourcePath: "foodCategories/\(category.id ?? UUID())/food").getAll { result in
                    switch result {
                    case .success(let foods):
                        self.foods = foods
                        self.output?.receiveData(foods: foods)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    self.dispatchSemaphore.signal()
                    self.group.leave()
                }
                self.dispatchSemaphore.wait()
            }
        }
        group.notify(queue: dispatchQueue, execute: { [self] in
            DispatchQueue.main.async {
                self.output?.reloadCollection()
            }
        })
    }
    
}
