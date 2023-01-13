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
    let eventsRequest = ApiService<EventModel>(resourcePath: "events")
    let categoryRequest = ApiService<CategoryModel>(resourcePath: "categories")
    private let group = DispatchGroup()
}

extension EventsInteractor: EventsInteractorInput {
    func loadData() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.eventsRequest.getAll { [weak self] eventResult in
                guard let self = self else { return }
                switch eventResult {
                case .failure (_):
                    self.group.leave()
                    self.output?.didFail(message: "There was an error getting the Events")
                case .success(let event):
                    self.group.leave()
                    self.events = event
                }
            }
        }
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.categoryRequest.getAll { [weak self] categoryResult in
                guard let self = self else { return }
                self.group.leave()
                switch categoryResult {
                case .failure (_):
                    self.output?.didFail(message: "There was an error getting the categories")
                case .success(let categories):
                    self.categories = categories
                }
            }
        }
        
        group.notify(queue: .main, execute: { [weak self] in
            guard let self = self else { return }
            self.output?.receiveDataSegment(allEvent: self.events, category: self.categories)
        })
    }
}
