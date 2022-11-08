//
//  CreateEventCategoryPivot.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
struct CreateEventCategoryPivot: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("event-category-pivot")
      .id()
      .field("eventID", .uuid, .required, .references("events", "id", onDelete: .cascade))
      .field("categoryID", .uuid, .required, .references("categories", "id", onDelete: .cascade))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("event-category-pivot").delete()
  }
}
