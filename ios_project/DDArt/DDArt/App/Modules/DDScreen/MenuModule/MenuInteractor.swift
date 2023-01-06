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
    var foods = [FoodModel]()
}

extension MenuInteractor: MenuInteractorInput {
    func loadData(categories: [FoodCategory]) {
        categories.forEach { category in
            print("LOGIC 1")
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                ApiService<FoodModel>(resourcePath: "foodCategories/\(category.id ?? UUID())/food").getAll { result in
                    switch result {
                    case .success(let foods):
                        self.foods = foods
                        self.output?.receiveData(foods: foods)
                        print("LOGIC \(foods)")
                    case .failure(let error):
                        print("LOGIC \(error)")
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            self.output?.reloadCollection()
        })
    }
    
}
