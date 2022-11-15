//
//  EventsSearchPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsSearchPresenter {
	weak var view: EventsSearchViewInput?
    weak var moduleOutput: EventsSearchModuleOutput?

	private let router: EventsSearchRouterInput
	private let interactor: EventsSearchInteractorInput

    init(router: EventsSearchRouterInput, interactor: EventsSearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsSearchPresenter: EventsSearchModuleInput {
}

extension EventsSearchPresenter: EventsSearchViewOutput {
}

extension EventsSearchPresenter: EventsSearchInteractorOutput {
}
