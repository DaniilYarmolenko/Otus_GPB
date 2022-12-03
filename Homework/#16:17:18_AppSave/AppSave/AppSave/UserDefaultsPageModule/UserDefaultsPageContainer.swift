//
//  UserDefaultsPageContainer.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class UserDefaultsPageContainer {
    let input: UserDefaultsPageModuleInput
	let viewController: UIViewController
	private(set) weak var router: UserDefaultsPageRouterInput!

	class func assemble(with context: UserDefaultsPageContext) -> UserDefaultsPageContainer {
        let router = UserDefaultsPageRouter()
        let interactor = UserDefaultsPageInteractor()
        let presenter = UserDefaultsPagePresenter(router: router, interactor: interactor)
		let viewController = UserDefaultsPageViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return UserDefaultsPageContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: UserDefaultsPageModuleInput, router: UserDefaultsPageRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct UserDefaultsPageContext {
	weak var moduleOutput: UserDefaultsPageModuleOutput?
}
