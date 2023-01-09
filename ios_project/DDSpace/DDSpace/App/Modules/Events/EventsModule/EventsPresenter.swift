//
//  EventsPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsPresenter {
	weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    var model: String = ""
    var allEvents = [EventModel]()
    var eventsToday = [EventModel]()
    var eventsFuture = [EventModel]()
    var categories = [CategoryModel]()
    
	private let router: EventsRouterInput
	private let interactor: EventsInteractorInput

    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func loadAllData() {
        interactor.loadData()
    }
    
    func viewDidLoad() {
        interactor.loadData()
    }
    func getViews(){
        if let viewOut = view {
            let views = self.router.getViews(allEvent: allEvents, eventsToday: eventsToday, eventsFuture: eventsFuture, category: categories, view: viewOut)
            self.view?.receiveViews(with: views)
        }
    }
}
extension EventsPresenter: EventsInteractorOutput {
    func receiveDataSegment(allEvent: [EventModel], category: [CategoryModel]) {
        self.allEvents = allEvent
        self.categories = category
        let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
        self.eventsToday = allEvent.filter({ event in
            let dateEventStart = event.dateStart.toDate()
            let dateEventEnd = event.dateEnd.toDate()
            return dateEventStart <= dateToday &&
            dateEventEnd > dateToday
            
        })
        self.eventsFuture = allEvent.filter({ event in
            let dateEventStart = event.dateStart.toDate()
            return dateEventStart > dateToday
        })
        getViews()
    }
    
    func didFail(message: String) {
    }
    
    
}
