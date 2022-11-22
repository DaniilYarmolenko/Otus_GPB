//
//  CartContainer.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class CartContainer {
    let input: CartModuleInput
	let viewController: UIViewController
	private(set) weak var router: CartRouterInput!

	class func assemble(with context: CartContext) -> CartContainer {
        let router = CartRouter()
        let interactor = CartInteractor()
        let presenter = CartPresenter(router: router, interactor: interactor)
		let viewController = CartViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CartContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CartModuleInput, router: CartRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CartContext {
	weak var moduleOutput: CartModuleOutput?
}
