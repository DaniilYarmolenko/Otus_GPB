//
//  CreateFood.swift
//
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Foundation
import Fluent

struct CreateFood: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("foods")
      .id()
      .field("nameFood", .string, .required)
      .field("description", .string, .required)
      .field("photos", .array(of: .string))
      .field("cost", .date, .required)
      .unique(on: "nameFood")
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("foods").delete()
  }
}
