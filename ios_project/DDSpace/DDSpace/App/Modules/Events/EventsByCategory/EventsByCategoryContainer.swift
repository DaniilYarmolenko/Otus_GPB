//
//  EventsByCategoryContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class EventsByCategoryContainer {
    let input: EventsByCategoryModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsByCategoryRouterInput!

	class func assemble(with context: EventsByCategoryContext) -> EventsByCategoryContainer {
        let router = EventsByCategoryRouter()
        let interactor = EventsByCategoryInteractor()
        let presenter = EventsByCategoryPresenter(router: router, interactor: interactor)
		let viewController = EventsByCategoryViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.category = context.category
        router.navigationController = context.navigationController
		interactor.output = presenter

        return EventsByCategoryContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsByCategoryModuleInput, router: EventsByCategoryRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsByCategoryContext {
	weak var moduleOutput: EventsByCategoryModuleOutput?
    var category: CategoryModel
    var navigationController: UINavigationController?
}
