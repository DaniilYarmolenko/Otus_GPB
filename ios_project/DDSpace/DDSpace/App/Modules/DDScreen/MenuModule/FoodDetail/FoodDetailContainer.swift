//
//  FoodDetailContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodDetailContainer {
    let input: FoodDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: FoodDetailRouterInput!

	class func assemble(with context: FoodDetailContext) -> FoodDetailContainer {
        let router = FoodDetailRouter()
        let interactor = FoodDetailInteractor()
        let presenter = FoodDetailPresenter(router: router, interactor: interactor)
		let viewController = FoodDetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.food = context.food
		interactor.output = presenter

        return FoodDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FoodDetailModuleInput, router: FoodDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FoodDetailContext {
	weak var moduleOutput: FoodDetailModuleOutput?
    var food: FoodModel
}
