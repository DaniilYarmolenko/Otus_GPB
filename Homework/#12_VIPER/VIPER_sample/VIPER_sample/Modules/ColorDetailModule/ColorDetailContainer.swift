//
//  ColorDetailContainer.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorDetailContainer {
    let input: ColorDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: ColorDetailRouterInput!

	class func assemble(with context: ColorDetailContext) -> ColorDetailContainer {
        let router = ColorDetailRouter()
        let interactor = ColorDetailInteractor()
        let presenter = ColorDetailPresenter(router: router, interactor: interactor)
        let viewController = ColorDetailViewController(output: presenter)

        presenter.view = viewController
        
		presenter.moduleOutput = context.moduleOutput
        presenter.color = context.colorType
        
		interactor.output = presenter

        return ColorDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ColorDetailModuleInput, router: ColorDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ColorDetailContext {
	weak var moduleOutput: ColorDetailModuleOutput?
    var colorType: Color
}
