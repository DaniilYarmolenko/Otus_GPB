//
//  MenuPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import Foundation

final class MenuPresenter {
	weak var view: MenuViewInput?
    weak var moduleOutput: MenuModuleOutput?
    var categoriesFood = [FoodCategory]()
	private let router: MenuRouterInput
	private let interactor: MenuInteractorInput
    var foods = [[FoodModel]]()

    init(router: MenuRouterInput, interactor: MenuInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MenuPresenter: MenuModuleInput {
}

extension MenuPresenter: MenuViewOutput {
    func loadData() {
        interactor.loadData(categories: categoriesFood)
    }
    func getCategoriesName(index: Int) -> String {
        categoriesFood[index].name
    }
    
    func getCountSections() -> Int {
        categoriesFood.count
    }
    
    func getCountNumberInSection(section: Int) -> Int {
        if !foods.isEmpty{
            return foods[section].count
        }
        return 0
    }
    
    func getCell(section: Int, index: Int) -> FoodModel {
        foods[section][index]
    }
    
    func tapOnFood(section: Int, index: Int) {
        let food = foods[section][index]
        router.goToDetailFood(food: food)
    }
    
}

extension MenuPresenter: MenuInteractorOutput {
    func receiveData(foods: [FoodModel]) {
        self.foods.append(foods)
    }
    func reloadCollection(){
        print("LOGIC foods \(foods)")
        view?.reloadCollection()
    }
    
}
