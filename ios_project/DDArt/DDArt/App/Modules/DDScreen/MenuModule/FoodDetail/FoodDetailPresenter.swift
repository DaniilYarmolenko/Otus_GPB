//
//  FoodDetailPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class FoodDetailPresenter {
	weak var view: FoodDetailViewInput?
    weak var moduleOutput: FoodDetailModuleOutput?
    var food: FoodModel?

	private let router: FoodDetailRouterInput
	private let interactor: FoodDetailInteractorInput

    init(router: FoodDetailRouterInput, interactor: FoodDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FoodDetailPresenter: FoodDetailModuleInput {
}

extension FoodDetailPresenter: FoodDetailViewOutput {
    func getTitle() -> String {
        food?.nameFood ?? ""
    }
    
    func goToCart() {
        router.goToCart(with: view)
    }
    
    func addToCoreData(image: Data) {
        let food = FoodSaveModel(
            id: "\(food?.id ?? UUID())",
            nameFood: food?.nameFood ?? "",
            data: image,
            count: 1,
            cost: food?.cost ?? 0)
        interactor.addToCoreData(food: food)
    }
    
    func deleteFromCoreData() {
        interactor.deleteFromCoreData(id: "\(food?.id ?? UUID())")
    }
    
    func getFoodCountInCart() -> Int {
        interactor.getFoodCountInCart(id: "\(food?.id ?? UUID())")
    }
    
    func updateFood(image: Data, value: Int) {
        let food = FoodSaveModel(
            id: "\(food?.id ?? UUID())",
            nameFood: food?.nameFood ?? "",
            data: image,
            count: value,
            cost: food?.cost ?? 0)
        interactor.updateFood(food: food)
    }
    
    func viewDidLoad() {
        if let food = food {
            view?.updateData(food: food)
        }
    }
    
}

extension FoodDetailPresenter: FoodDetailInteractorOutput {
}
