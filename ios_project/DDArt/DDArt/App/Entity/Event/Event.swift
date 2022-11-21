//
//  Event.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 15.11.2022.
//

import Foundation

final class Event: Codable {
    
    enum EventType: Codable {
        case admin
        case standard
    }
    
    var id: UUID?
    var authorName: String
    var nameEvent: String
    var description: String
    var photos: [String]
    var dateStart: String
    var dateEnd: String
    var eventType: EventType
    
    init(authorName: String, nameEvent: String, description: String, photos: [String], dateStart: String, dateEnd: String, eventType: EventType) {
        self.authorName = authorName
        self.nameEvent = nameEvent
        self.description = description
        self.photos = photos
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.eventType = eventType
    }
}

