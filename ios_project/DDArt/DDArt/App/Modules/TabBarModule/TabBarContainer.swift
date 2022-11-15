//
//  TabBarContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class TabBarContainer {
    let input: TabBarModuleInput
	let viewController: UIViewController
	private(set) weak var router: TabBarRouterInput!

	class func assemble(with context: TabBarContext) -> TabBarContainer {
        let router = TabBarRouter()
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter(router: router, interactor: interactor)
		let viewController = TabBarViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TabBarContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TabBarModuleInput, router: TabBarRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TabBarContext {
	weak var moduleOutput: TabBarModuleOutput?
}
