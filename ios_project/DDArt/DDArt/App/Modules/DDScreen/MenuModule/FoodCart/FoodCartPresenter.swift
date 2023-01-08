//
//  FoodCartPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class FoodCartPresenter {
	weak var view: FoodCartViewInput?
    weak var moduleOutput: FoodCartModuleOutput?
    var array = [FoodSaveModel]()
	private let router: FoodCartRouterInput
	private let interactor: FoodCartInteractorInput

    init(router: FoodCartRouterInput, interactor: FoodCartInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FoodCartPresenter: FoodCartModuleInput {
}

extension FoodCartPresenter: FoodCartViewOutput {
    func getTotalAmount() {
        
    }
    
    func viewDidLoad() {
        interactor.getCoreDataItems()
    }
    
    func checkEmpty() -> Bool {
        array.isEmpty
    }
    
    func deleteAll() {
        router.goToDeleteAlert(from: view)
    }
    
    func delete(id: String) {
        interactor.deleteBy(with: id)
    }
    
    func updateCount(food: FoodSaveModel) {
        interactor.countUpdate(food: food)
    }
    
    func getCellsCount() -> Int {
        array.count
    }
    
    func getCell(id: Int) -> FoodSaveModel {
        array[id]
    }
    
}

extension FoodCartPresenter: FoodCartInteractorOutput {
    func receiveCoreDataItems(foods: [FoodSaveModel]) {
        array = foods
        view?.loadData()
    }
    
}
