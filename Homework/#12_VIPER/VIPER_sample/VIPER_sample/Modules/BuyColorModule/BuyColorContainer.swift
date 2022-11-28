//
//  BuyColorContainer.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//  
//

import UIKit

final class BuyColorContainer {
    let input: BuyColorModuleInput
	let viewController: UIViewController
	private(set) weak var router: BuyColorRouterInput!

	class func assemble(with context: BuyColorContext) -> BuyColorContainer {
        let router = BuyColorRouter()
        let interactor = BuyColorInteractor()
        let presenter = BuyColorPresenter(router: router, interactor: interactor)
		let viewController = BuyColorViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.modelInput = context.modelInput
		interactor.output = presenter

        return BuyColorContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: BuyColorModuleInput, router: BuyColorRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct BuyColorContext {
	weak var moduleOutput: BuyColorModuleOutput?
    weak var modelInput: ColorDetailModel?
}
