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
    private var eventFuture = [EventModel]()
}

extension EventsFutureInteractor: EventsFutureInteractorInput {
    func loadFutureEvents() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    print(error.localizedDescription)
                case .success(let event):
                    let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
                    self.eventFuture = event.filter({ event in
                        let dateEventEnd = event.dateEnd.toDate()
                        return dateEventEnd > dateToday
                    })
                    sleep(1)
                    self.group.leave()
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.receiveData(events: eventFuture)
        })
    }
    
}
