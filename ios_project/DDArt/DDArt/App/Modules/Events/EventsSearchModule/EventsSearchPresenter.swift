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
    var categories = [CategoryModel]()
    var events = [EventModel]()
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
    func viewDidload() {
        interactor.loadAllCategories()
    }
    
    func getCountEventCells() -> Int {
        events.count
    }
    
    func clickOnEvent(with id: Int) {
        router.eventSelected(with: view, and: events[id])
    }
    
    func sortEvents(typeSort type: typeSort, by order: Ordered = .increasing) {
        var eventsSort = [EventModel]()
        switch type {
        case .name:
            switch order {
            case .increasing:
                eventsSort = events.sorted() { first, second in
                    return first.nameEvent > second.nameEvent
                }
            case .descending:
                eventsSort = events.sorted() {
                    $0.nameEvent < $1.nameEvent
                }
            }
        case .dateEvent:
            switch order {
            case .increasing:
//                $0.dateStart.toDate > $0.dateStart.toDate MARK: Add to date method
                break
            case .descending:
//                $0.dateStart.toDate < $0.dateStart.toDate
                break
            }
        }
        recieveEvents(events: eventsSort)
    }
    
    func searchEventByName(with name: String) {
        interactor.searchEventByName(with: name)
    }
    
    func getCountCategoryCells() -> Int {
        categories.count
    }
    
    func clickOnCategory(with id: Int) {
        router.categorySelected(with: view, and: categories[id])
    }
    
}

extension EventsSearchPresenter: EventsSearchInteractorOutput {
    func recieveCategories(categories: [CategoryModel]) {
        self.categories = categories
    }
    
    func recieveEvents(events: [EventModel]) {
        self.events = events
    }
    
}
