//
//  CreateCategory.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent

struct CreateCategory: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("categories")
      .id()
      .field("name", .string, .required)
      .field("photos", .array(of: .string), .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("categories").delete()
  }
}
