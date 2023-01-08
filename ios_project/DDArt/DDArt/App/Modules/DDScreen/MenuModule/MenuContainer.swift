//
//  MenuContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import UIKit

final class MenuContainer {
    let input: MenuModuleInput
	let viewController: UIViewController
	private(set) weak var router: MenuRouterInput!

	class func assemble(with context: MenuContext) -> MenuContainer {
        let router = MenuRouter()
        let interactor = MenuInteractor()
        let presenter = MenuPresenter(router: router, interactor: interactor)
		let viewController = MenuViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.categoriesFood = context.categoryFood.sorted {$0.name < $1.name}
        router.navigationController = context.navigationController
		interactor.output = presenter
        viewController.scrollSection = context.scrollSection

        return MenuContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MenuModuleInput, router: MenuRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MenuContext {
	weak var moduleOutput: MenuModuleOutput?
    var categoryFood: [FoodCategory]
    var navigationController: UINavigationController
    var scrollSection: Int?
}
