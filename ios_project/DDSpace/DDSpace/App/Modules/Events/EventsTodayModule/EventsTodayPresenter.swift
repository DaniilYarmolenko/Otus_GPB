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
    
    func loadData() {
        interactor.loadTodayEvents()
    }
    
    func getCell(with index: Int) -> EventModel {
        self.events?[index] ?? EventModel(authorName: "222", nameEvent: "222", description: "222", photos: [], dateStart: "333", dateEnd: "333", eventType: .standard)
    }
    
    func clickOnRegisterButton(with id: UUID?) {
        if Auth().token == nil {
            router.showAlertAuth(with: view)
        } else {
            router.showOpsAlert(with: view)
        }
    }
    
    func clickOnEvent(with id: Int) {
        if let event = events?[id] {
            router.eventSelected(event: event)
        }
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
    func didFail(message: String) {
        view?.reloadData()
    }
    
}
