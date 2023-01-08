//
//  FoodCartProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol FoodCartModuleInput {
	var moduleOutput: FoodCartModuleOutput? { get }
}

protocol FoodCartModuleOutput: AnyObject {
}

protocol FoodCartViewInput: AnyObject {
    func  loadData()
}

protocol FoodCartViewOutput: AnyObject {
    func viewDidLoad()
    func checkEmpty() -> Bool
    func deleteAll()
    func delete(id: String)
    func getTotalAmount()
    func updateCount(food: FoodSaveModel)
    func getCellsCount() -> Int
    func getCell(id: Int) -> FoodSaveModel
}

protocol FoodCartInteractorInput: AnyObject {
    var totalAmount: Int { get set}
    func getCoreDataItems()
    func deleteBy(with id: String)
    func deleteAll()
    func countUpdate(food: FoodSaveModel)
}

protocol FoodCartInteractorOutput: AnyObject {
    func receiveCoreDataItems(foods: [FoodSaveModel])
}

protocol FoodCartRouterInput: AnyObject {
    func goToDeleteAlert(from vc: FoodCartViewInput?)
}
