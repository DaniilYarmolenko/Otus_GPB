//
//  Category.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
import Vapor

final class Category: Model, Content {
    static let schema = "categories"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "photo")
    var photo: [String]?
    
    @Siblings(through: EventCategoryPivot.self, from: \.$category, to: \.$event)
    var event: [Event]
    
    init() {}
    
    init(id: UUID? = nil, name: String, photo: [String]? = nil) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}

extension Category {
    static func addCategory(_ name: String, to event: Event, on req: Request) -> EventLoopFuture<Void> {
        Category.query(on: req.db)
            .filter(\.$name == name)
            .first()
            .flatMap { foundCategory in
                if let existingCategory = foundCategory {
                    return event.$categories
                        .attach(existingCategory, on: req.db)
                } else {
                    let category = Category(name: name)
                    return category.save(on: req.db).flatMap {
                        event.$categories
                            .attach(category, on: req.db)
                    }
                }
            }
    }
}
