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
    var events: [EventModel]?
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
    func viewDidLoad() {
        interactor.loadFutureEvents()
    }
    
    func getCountCell() -> Int {
        events?.count ?? 0
    }
    
    func clickOnEvent(with id: Int) {
        moduleOutput?.event = events?[id]
        if let event = moduleOutput?.event {
            router.eventSelected(with: view, and: event)
        }
    }
    
}

extension EventsFuturePresenter: EventsFutureInteractorOutput {
    func receiveData(events: [EventModel]) {
        self.events = events
        view?.reloadData()
    }
    
}
