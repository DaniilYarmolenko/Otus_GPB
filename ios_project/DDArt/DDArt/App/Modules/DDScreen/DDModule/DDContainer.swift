//
//  DDContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class DDContainer {
    let input: DDModuleInput
	let viewController: UIViewController
	private(set) weak var router: DDRouterInput!

	class func assemble(with context: DDContext) -> DDContainer {
        let router = DDRouter()
        let interactor = DDInteractor()
        let presenter = DDPresenter(router: router, interactor: interactor)
		let viewController = DDViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return DDContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: DDModuleInput, router: DDRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct DDContext {
	weak var moduleOutput: DDModuleOutput?
}
