//
//  CoreDataPageContainer.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class CoreDataPageContainer {
    let input: CoreDataPageModuleInput
	let viewController: UIViewController
	private(set) weak var router: CoreDataPageRouterInput!

	class func assemble(with context: CoreDataPageContext) -> CoreDataPageContainer {
        let router = CoreDataPageRouter()
        let interactor = CoreDataPageInteractor()
        let presenter = CoreDataPagePresenter(router: router, interactor: interactor)
		let viewController = CoreDataPageViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CoreDataPageContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CoreDataPageModuleInput, router: CoreDataPageRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CoreDataPageContext {
	weak var moduleOutput: CoreDataPageModuleOutput?
}
