//
//  EventsSearchContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsSearchContainer {
    let input: EventsSearchModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsSearchRouterInput!

	class func assemble(with context: EventsSearchContext) -> EventsSearchContainer {
        let router = EventsSearchRouter()
        let interactor = EventsSearchInteractor()
        let presenter = EventsSearchPresenter(router: router, interactor: interactor)
		let viewController = EventsSearchViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.events = context.allEvents
        presenter.categories = context.categories
        presenter.searchEvents = context.allEvents
        router.navigationController = context.navigationController
		interactor.output = presenter

        return EventsSearchContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsSearchModuleInput, router: EventsSearchRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsSearchContext {
	weak var moduleOutput: EventsSearchModuleOutput?
    var allEvents: [EventModel]
    var categories: [CategoryModel]
    weak var navigationController: UINavigationController?
}
