//
//  EventsSearchPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

final class EventsSearchPresenter {
    weak var view: EventsSearchViewInput?
    weak var moduleOutput: EventsSearchModuleOutput?
    var categories = [CategoryModel]()
    var events = [EventModel]()
    var searchEvents = [EventModel]()
    private let router: EventsSearchRouterInput
    private let interactor: EventsSearchInteractorInput
    weak var navigationController: UINavigationController?
    
    init(router: EventsSearchRouterInput, interactor: EventsSearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsSearchPresenter: EventsSearchModuleInput {
}

extension EventsSearchPresenter: EventsSearchViewOutput {
    func updateEvents() {
        interactor.loadAllEvents()
    }
    
    func getEventCell(with index: Int) -> EventModel {
        searchEvents[index]
    }
    
    func getCategoryCell(with index: Int) -> CategoryModel {
        categories[index]
    }
    
    func viewDidload() {
        interactor.loadAllCategories()
    }
    
    func getCountEventCells() -> Int {
        searchEvents.count
    }
    
    func clickOnEvent(with id: Int) {
        router.eventSelected(event: events[id])
    }
    
    func sortEvents(typeSort type: typeSort, by order: Ordered = .increasing) {
        var eventsSort = [EventModel]()
        switch type {
        case .name:
            switch order {
            case .increasing:
                eventsSort = searchEvents.sorted() { first, second in
                    return first.nameEvent > second.nameEvent
                }
            case .descending:
                eventsSort = searchEvents.sorted() {
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
        searchEvents = events.filter { $0.nameEvent.lowercased().contains(name) || $0.authorName.lowercased().contains(name)}
        recieveEventsSearch(events: searchEvents)
    }
    
    func getCountCategoryCells() -> Int {
        categories.count
    }
    
    func clickOnCategory(with id: Int) {
        router.categorySelected(category: categories[id])
    }
    
}

extension EventsSearchPresenter: EventsSearchInteractorOutput {
    func recieveEventsSearch(events: [EventModel]) {
        view?.reloadTableData()
    }
    
    func recieveCategories(categories: [CategoryModel]) {
        self.categories = categories
        view?.reloadCategory()
    }
    
    func recieveEvents(events: [EventModel]) {
        self.events = events
    }
    
}
