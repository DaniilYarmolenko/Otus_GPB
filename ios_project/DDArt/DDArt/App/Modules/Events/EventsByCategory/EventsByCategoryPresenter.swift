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
    func viewDidLoad() {
        if let category = category {
            interactor.loadEventsByCategory(category: category)
        }
    }
    
    func getCountCell() -> Int {
        return events.count
        print(events)
        print(category)
    }
    
    func clickOnEvent(with id: Int) {
        router.eventSelected(with: view, and: events[id])
    }
    
}

extension EventsByCategoryPresenter: EventsByCategoryInteractorOutput {
    func receiveData(events: [EventModel]) {
        self.events = events
        view?.reloadData()
    }
    
}
