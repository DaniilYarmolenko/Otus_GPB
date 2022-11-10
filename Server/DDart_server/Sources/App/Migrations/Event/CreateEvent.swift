//
//  CreateEvent.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Foundation
import Fluent

struct CreateEvent: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
      database.enum("eventType")
          .case("admin")
          .case("standard")
          .create()
          .flatMap { eventType in
              database.schema("events")
                .id()
                .field("authorName", .string, .required)
                .field("nameEvent", .string, .required)
                .field("description", .string, .required)
                .field("photos", .array(of: .string), .required)
                .field("dateStartEvent", .string, .required)
                .field("dateEndEvent", .string, .required)
                .field("eventType", eventType, .required)
                .unique(on: "nameEvent")
                .create()
          }
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("events").delete()
  }
}
