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
    func loadData(categories: [FoodCategory]) {
        dispatchQueue.async {
            categories.forEach { category in
                print("LOGIC 1")
                self.group.enter()
                ApiService<FoodModel>(resourcePath: "foodCategories/\(category.id ?? UUID())/food").getAll { result in
                    switch result {
                    case .success(let foods):
                        self.foods = foods
                        self.output?.receiveData(foods: foods)
                        print("LOGIC \(foods)")
                    case .failure(let error):
                        print("LOGIC \(error)")
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
