//
//  File.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor
import Fluent

final class EventToken: Model {
    static let schema = "eventTokens"
    
    @ID
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    @Parent(key: "userID")
    var user: User
    
    @Parent(key: "eventID")
    var event: Event
    
    @Field(key: "life")
    var life: Bool
    
    init() {}
    
    init(id: UUID? = nil, value: String, userID: User.IDValue, eventID: Event.IDValue, life: Bool = false) {
        self.id = id
        self.value = value
        self.$user.id = userID
        self.$event.id = eventID
        self.life = life
    }
}
extension EventToken: Content {}
