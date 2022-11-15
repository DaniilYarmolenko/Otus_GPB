//
//  EventsTodayPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsTodayPresenter {
	weak var view: EventsTodayViewInput?
    weak var moduleOutput: EventsTodayModuleOutput?

	private let router: EventsTodayRouterInput
	private let interactor: EventsTodayInteractorInput

    init(router: EventsTodayRouterInput, interactor: EventsTodayInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsTodayPresenter: EventsTodayModuleInput {
}

extension EventsTodayPresenter: EventsTodayViewOutput {
}

extension EventsTodayPresenter: EventsTodayInteractorOutput {
}
