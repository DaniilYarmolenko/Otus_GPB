//
//  EventsSearchInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsSearchInteractor {
	weak var output: EventsSearchInteractorOutput?
}

extension EventsSearchInteractor: EventsSearchInteractorInput {
    func loadAllEvents() -> [EventModel]  {
        [EventModel(authorName: "", nameEvent: "", description: "", photos: [], dateStart: "", dateEnd: "", eventType: .admin)]
    }
    
    func loadAllCategories() {
//        MARK: API get request
        //        output?.recieveCategories(categories: <#T##[Category]#>)
    }
    
    func searchEventByName(with name: String) {
        let allEvents = loadAllEvents()
        let searchEvents = allEvents.filter { $0.nameEvent.contains(name) || $0.authorName.contains(name)
        }
        output?.recieveEvents(events: searchEvents)
    }
    
}
