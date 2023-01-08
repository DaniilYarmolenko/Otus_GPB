//
//  EventDetailContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import UIKit

final class EventDetailContainer {
    let input: EventDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventDetailRouterInput!

	class func assemble(with context: EventDetailContext) -> EventDetailContainer {
        let router = EventDetailRouter()
        let interactor = EventDetailInteractor()
        let presenter = EventDetailPresenter(router: router, interactor: interactor)
		let viewController = EventDetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.event = context.event
		interactor.output = presenter

        return EventDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventDetailModuleInput, router: EventDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventDetailContext {
	weak var moduleOutput: EventDetailModuleOutput?
    var event: EventModel
}
