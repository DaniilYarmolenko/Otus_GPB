//
//  EventsByCategoryPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

final class EventsByCategoryPresenter {
    weak var view: EventsByCategoryViewInput?
    weak var moduleOutput: EventsByCategoryModuleOutput?
    var events = [EventModel]()
    var category: CategoryModel?
    private let router: EventsByCategoryRouterInput
    private let interactor: EventsByCategoryInteractorInput
    
    init(router: EventsByCategoryRouterInput, interactor: EventsByCategoryInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsByCategoryPresenter: EventsByCategoryModuleInput {
}

extension EventsByCategoryPresenter: EventsByCategoryViewOutput {
    func getTitle() -> String {
        category?.name ?? ""
    }
    
    func getCountEventCells() -> Int {
        events.count
    }
    
    func getEventCell(with index: Int) -> EventModel {
        events[index]
    }
    
    func viewDidLoad() {
        if let category = category {
            interactor.loadEventsByCategory(category: category)
        }
    }
    
    func clickOnEvent(with id: Int) {
        router.eventSelected(event: events[id])
    }
    
}

extension EventsByCategoryPresenter: EventsByCategoryInteractorOutput {
    func receiveData(events: [EventModel]) {
        self.events = events
        view?.reloadData()
    }
    
}
