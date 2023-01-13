//
//  EventsTodayInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsTodayInteractor {
    weak var output: EventsTodayInteractorOutput?
    var eventsRequest = ApiService<EventModel>(resourcePath: "events")
    private var eventToday = [EventModel]()
    private let group = DispatchGroup()
}

extension EventsTodayInteractor: EventsTodayInteractorInput {
    
    func loadTodayEvents() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    self.output?.didFail(message: "There was an error getting the Events\(error)")
                case .success(let event):
                    let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
                    self.eventToday = event.filter({ event in
                        let dateEventStart = event.dateStart.toDate()
                        let dateEventEnd = event.dateEnd.toDate()
                        return dateEventStart <= dateToday &&
                        dateEventEnd > dateToday
                    })
                    self.group.leave()
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.receiveData(events: eventToday)
        })
    }
    
}
