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
    private let group = DispatchGroup()
    private var eventToday = [EventModel]()
    
}

extension EventsTodayInteractor: EventsTodayInteractorInput {
    
    func loadTodayEvents() {
        print("ZASHLI interactor")
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            eventsRequest.getAll { eventResult in
                switch eventResult {
                case .failure (let error):
                    print("ZASHLI oshibka")
                    self.group.leave()
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the Events")
                case .success(let event):
                    print("ZASHLI success")
                    sleep(2)
                    let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
                    self.eventToday = event.filter({ event in
                        print("ZASHLI filter")
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
            print("ZASHLI notify")
            output?.receiveData(events: eventToday)
        })
    }
    
}
