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
}

extension FoodDetailPresenter: FoodDetailInteractorOutput {
}
