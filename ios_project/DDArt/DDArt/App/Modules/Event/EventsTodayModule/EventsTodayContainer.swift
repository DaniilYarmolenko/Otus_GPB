//
//  EventsTodayContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayContainer {
    let input: EventsTodayModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsTodayRouterInput!

	class func assemble(with context: EventsTodayContext) -> EventsTodayContainer {
        let router = EventsTodayRouter()
        let interactor = EventsTodayInteractor()
        let presenter = EventsTodayPresenter(router: router, interactor: interactor)
		let viewController = EventsTodayViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EventsTodayContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsTodayModuleInput, router: EventsTodayRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsTodayContext {
	weak var moduleOutput: EventsTodayModuleOutput?
}
