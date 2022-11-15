//
//  EventsFuturePresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsFuturePresenter {
	weak var view: EventsFutureViewInput?
    weak var moduleOutput: EventsFutureModuleOutput?

	private let router: EventsFutureRouterInput
	private let interactor: EventsFutureInteractorInput

    init(router: EventsFutureRouterInput, interactor: EventsFutureInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsFuturePresenter: EventsFutureModuleInput {
}

extension EventsFuturePresenter: EventsFutureViewOutput {
}

extension EventsFuturePresenter: EventsFutureInteractorOutput {
}
