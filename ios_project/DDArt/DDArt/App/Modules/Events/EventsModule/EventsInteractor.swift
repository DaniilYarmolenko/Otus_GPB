//
//  EventsInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation


final class EventsInteractor {
    
	weak var output: EventsInteractorOutput?
    private var events = [EventModel]()
    private var categories = [CategoryModel]()
    var eventsRequest = ApiService<EventModel>(resourcePath: "events")
    let categoryRequest = ApiService<CategoryModel>(resourcePath: "categories")
    private let group = DispatchGroup()
}

extension EventsInteractor: EventsInteractorInput {
    func loadData() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    self.group.leave()
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the Events")
                case .success(let event):
                    self.group.leave()
                    self.events = event
                }
            }
        }
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            categoryRequest.getAll { categoryResult in
                self.group.leave()
                switch categoryResult {
                case .failure (let error):
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the categories")
                case .success(let categories):
                    self.categories = categories
                }
            }
        }
        
        group.notify(queue: .main, execute: { [self] in
            output?.receiveDataSegment(allEvent: events, category: categories)
        })
    }
}
