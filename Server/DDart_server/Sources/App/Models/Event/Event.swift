//
//  Event.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor
import Fluent

final class Event: Model {
    static let schema = "events"
    
    @ID
    var id: UUID?
    
    @Field(key: "authorName")
    var authorName: String
    
    @Field(key: "nameEvent")
    var nameEvent: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "photos")
    var photos: [String]
    
    @Field(key: "dateStartEvent")
    var dateStart: String
    
    @Field(key: "dateEndEvent")
    var dateEnd: String
    
    @Enum(key: "eventType")
    var eventType: EventType

    @Children(for: \.$event)
    var eventTokens: [EventToken]
    
    
    @Siblings(through: EventCategoryPivot.self, from: \.$event, to: \.$category)
    var categories: [Category]
    
    init() {}
    
    init(id: UUID? = nil, authorName: String, nameEvent: String, description: String, photos: [String] = [], dateStart: String, dateEnd: String, eventType: EventType = .admin) {
        self.id = id
        self.authorName = authorName
        self.nameEvent = nameEvent
        self.description = description
        self.photos = photos
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.eventType = eventType
    }
}

extension Event: Content {}




extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy, HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "MSD")
        return formatter.date(from: self) ?? Date()
    }
}
extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy, HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "MSD")
        return formatter.string(from: self)
    }
}
enum EventType: String, Codable {
    case admin
    case standard
}
