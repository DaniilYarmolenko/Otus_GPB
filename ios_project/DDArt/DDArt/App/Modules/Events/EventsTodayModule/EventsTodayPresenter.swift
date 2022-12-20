//
//  EventsTodayPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit
final class EventsTodayPresenter {
	weak var view: EventsTodayViewInput?
    weak var moduleOutput: EventsTodayModuleOutput?
    var events: [EventModel]?
	private let router: EventsTodayRouterInput
	private let interactor: EventsTodayInteractorInput
    var navigationController: UINavigationController?
    init(router: EventsTodayRouterInput, interactor: EventsTodayInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsTodayPresenter: EventsTodayModuleInput {
}

extension EventsTodayPresenter: EventsTodayViewOutput {
    
    func loadData() {
        print("")
        interactor.loadTodayEvents()
    }
    
    func getCell(with index: Int) -> EventModel {
        self.events?[index] ?? EventModel(authorName: "222", nameEvent: "222", description: "222", photos: [], dateStart: "333", dateEnd: "333", eventType: .standard)
    }
    
    func clickOnRegisterButton(with id: UUID?) {
        
    }
    
    func clickOnEvent(with id: Int) {
        if let event = events?[id], let navigationController = navigationController{
            print("LOGIC CLICK \(id)")
            router.eventSelected(with: view, event: event, navigationController: navigationController)
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
        print(message)
        view?.reloadData()
    }
    
}
