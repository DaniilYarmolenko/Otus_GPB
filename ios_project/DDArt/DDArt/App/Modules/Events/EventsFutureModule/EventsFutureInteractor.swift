//
//  EventsFutureInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsFutureInteractor {
	weak var output: EventsFutureInteractorOutput?
    var eventsRequest = ApiService<EventModel>(resourcePath: "events")
    private let group = DispatchGroup()
    private var eventToday = [EventModel]()
}

extension EventsFutureInteractor: EventsFutureInteractorInput {
    func loadFutureEvents() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    self.group.leave()
//                    self.output?.didFail(message: "There was an error getting the Events")
                case .success(let event):
                    self.group.leave()
                    let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
                    self.eventToday = event.filter({ event in
                        let dateEventStart = event.dateStart.toDate()
                        let dateEventEnd = event.dateEnd.toDate()
                        return dateEventStart <= dateToday &&
                        dateEventEnd > dateToday
                    })
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.receiveData(events: eventToday)
        })
    }
    
}
