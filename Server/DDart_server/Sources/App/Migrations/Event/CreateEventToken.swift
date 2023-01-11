//
//  CreateEventToken.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
struct CreateEventToken: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("eventTokens")
      .id()
      .field("value", .string, .required)
      .field("life", .bool, . required)
      .field("userID", .uuid, .required, .references("users", "id"))
      .field("eventID", .uuid, .required, .references("events", "id"))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("eventTokens").delete()
  }
}
