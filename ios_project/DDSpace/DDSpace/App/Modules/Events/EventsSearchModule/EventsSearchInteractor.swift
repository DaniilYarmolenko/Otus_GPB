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
    private var category = [CategoryModel]()
    var categoryRequest = ApiService<CategoryModel>(resourcePath: "categories")
    var eventsRequest = ApiService<EventModel>(resourcePath: "events")
    private var eventAll = [EventModel]()
    private let group = DispatchGroup()
}

extension EventsSearchInteractor: EventsSearchInteractorInput {
    func loadAllEvents(){
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    print(error.localizedDescription)
                case .success(let events):
                    self.eventAll = events
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.recieveEvents(events: eventAll)
        })
    }
    
    func loadAllCategories() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            categoryRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    print(error.localizedDescription)
                case .success(let category):
                    self.category = category
                    self.group.leave()
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.recieveCategories(categories: category)
        })
    }
    
    func searchEventByName(with name: String) {
        let searchEvents = eventAll.filter { $0.nameEvent.contains(name) || $0.authorName.contains(name)
        }
        output?.recieveEvents(events: searchEvents)
    }
    
}
