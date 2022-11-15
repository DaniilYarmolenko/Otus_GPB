//
//  EventsFutureContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsFutureContainer {
    let input: EventsFutureModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsFutureRouterInput!

	class func assemble(with context: EventsFutureContext) -> EventsFutureContainer {
        let router = EventsFutureRouter()
        let interactor = EventsFutureInteractor()
        let presenter = EventsFuturePresenter(router: router, interactor: interactor)
		let viewController = EventsFutureViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EventsFutureContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsFutureModuleInput, router: EventsFutureRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsFutureContext {
	weak var moduleOutput: EventsFutureModuleOutput?
}
