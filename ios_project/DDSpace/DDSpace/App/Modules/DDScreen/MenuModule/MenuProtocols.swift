//
//  MenuProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import Foundation

protocol MenuModuleInput {
    var moduleOutput: MenuModuleOutput? { get }
}

protocol MenuModuleOutput: AnyObject {
}

protocol MenuViewInput: AnyObject {
    func reloadCollection()
    func goToCategory(section: Int)
}

protocol MenuViewOutput: AnyObject {
    func loadData()
    func selectCategory(index: Int)
    func getCategoriesName(index: Int) -> String
    func getCountSections() -> Int
    func getCountNumberInSection(section: Int) -> Int
    func getCell(section: Int, index: Int) -> FoodModel
    func tapOnFood(section: Int, index: Int)
    func countCart() -> Int
    func goToCart()
}

protocol MenuInteractorInput: AnyObject {
    func loadData(categories: [FoodCategory])
    func countCart() -> Int
}

protocol MenuInteractorOutput: AnyObject {
    func receiveData(foods: [FoodModel])
    func reloadCollection()
}

protocol MenuRouterInput: AnyObject {
    func goToDetailFood(food: FoodModel)
    func goToCart()
}
protocol ServiceCoreDataInput: AnyObject {
    func isContain(with name: String) -> Bool
    func delete(with id: String )
    func insert(with model: FoodSaveModel)
    func fetchAll() -> [CartCoreModel]
    func deleteAll()
}
