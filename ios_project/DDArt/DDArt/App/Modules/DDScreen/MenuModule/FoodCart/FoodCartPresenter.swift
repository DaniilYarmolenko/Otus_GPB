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
}

extension FoodCartPresenter: FoodCartInteractorOutput {
}
