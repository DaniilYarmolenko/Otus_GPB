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
    var events: [EventModel]?
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
    func clickOnEvent(with id: Int) {
        moduleOutput?.event = events?[id]
        if let event = moduleOutput?.event {
            router.eventSelected(with: view, and: event)
        }
    }
    
    func viewDidLoad() {
        interactor.loadTodayEvents()
    }
    
    func getCountCell() -> Int {
        events?.count ?? 0
    }
    
}

extension EventsTodayPresenter: EventsTodayInteractorOutput {
    func receiveData(events: [EventModel]) {
        self.events = events
        view?.reloadData()
    }
    
}
