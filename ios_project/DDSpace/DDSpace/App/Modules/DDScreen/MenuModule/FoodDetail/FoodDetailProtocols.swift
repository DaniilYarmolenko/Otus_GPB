//
//  FoodDetailProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol FoodDetailModuleInput {
    var moduleOutput: FoodDetailModuleOutput? { get }
}

protocol FoodDetailModuleOutput: AnyObject {
}

protocol FoodDetailViewInput: AnyObject {
    func updateData(food: FoodModel)
}

protocol FoodDetailViewOutput: AnyObject {
    func viewDidLoad()
    func getFoodCountInCart() -> Int
    func addToCoreData(image: Data)
    func deleteFromCoreData()
    func updateFood(image: Data, value: Int)
    func goToCart()
    func getTitle() -> String
}

protocol FoodDetailInteractorInput: AnyObject {
    func getFoodCountInCart(id: String) -> Int
    func updateFood(food: FoodSaveModel)
    func addToCoreData(food: FoodSaveModel)
    func deleteFromCoreData(id: String)
}

protocol FoodDetailInteractorOutput: AnyObject {
}

protocol FoodDetailRouterInput: AnyObject {
    func goToCart(with view: FoodDetailViewInput?)
}
