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
}

protocol MenuViewOutput: AnyObject {
    func loadData()
    func getCategoriesName(index: Int) -> String
    func getCountSections() -> Int
    func getCountNumberInSection(section: Int) -> Int
    func getCell(section: Int, index: Int) -> FoodModel
    func tapOnFood(section: Int, index: Int)
}

protocol MenuInteractorInput: AnyObject {
    func loadData(categories: [FoodCategory])
}

protocol MenuInteractorOutput: AnyObject {
    func receiveData(foods: [FoodModel])
    func reloadCollection()
}

protocol MenuRouterInput: AnyObject {
    func goToDetailFood(food: FoodModel)
}
