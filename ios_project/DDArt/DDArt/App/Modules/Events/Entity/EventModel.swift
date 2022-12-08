//
//  Event.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class EventModel: Codable {
    var id: UUID?
    var authorName: String
    var nameEvent: String
    var description: String
    var photos: [String]
    var dateStart: String
    var dateEnd: String
    var eventType: EventType
    
    init(id: UUID? = nil, authorName: String, nameEvent: String, description: String, photos: [String], dateStart: String, dateEnd: String, eventType: EventType) {
        self.authorName = authorName
        self.nameEvent = nameEvent
        self.description = description
        self.photos = photos
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.eventType = eventType
    }
}

enum typeSort {
    case name
    case dateEvent
}
enum Ordered {
    case increasing
    case descending
}
enum EventType: Codable, CodingKey {
    case standard
    case admin
}
