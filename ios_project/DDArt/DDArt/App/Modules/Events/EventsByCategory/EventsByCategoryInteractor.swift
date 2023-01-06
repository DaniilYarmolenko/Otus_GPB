//
//  EventsByCategoryInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

final class EventsByCategoryInteractor {
    weak var output: EventsByCategoryInteractorOutput?
    private let group = DispatchGroup()
    private var events = [EventModel]()
}

extension EventsByCategoryInteractor: EventsByCategoryInteractorInput {
    func loadEventsByCategory(category: CategoryModel) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            ApiService<EventModel>(resourcePath: "categories/\(category.id ?? UUID())/events").getAll { result in
                self.group.leave()
                switch result {
                    
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    print("LOGIC \(error)")
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            print(self.events)
            output?.receiveData(events: self.events)
        })
    }
}
