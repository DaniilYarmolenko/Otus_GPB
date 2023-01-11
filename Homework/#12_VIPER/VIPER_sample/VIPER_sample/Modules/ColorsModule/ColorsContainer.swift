//
//  ColorsContainer.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorsContainer {
    let input: ColorsModuleInput
	let viewController: UIViewController
	private(set) weak var router: ColorsRouterInput!

	class func assemble(with context: ColorsContext) -> ColorsContainer {
        let router = ColorsRouter()
        let interactor = ColorsInteractor()
        let presenter = ColorsPresenter(router: router, interactor: interactor)
		let viewController = ColorsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ColorsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ColorsModuleInput, router: ColorsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ColorsContext {
	weak var moduleOutput: ColorsModuleOutput?
}
