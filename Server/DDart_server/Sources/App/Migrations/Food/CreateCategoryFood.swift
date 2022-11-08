//
//  CreateCategoryFood.swift
//
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent

struct CreateCategoryFood: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("category-food")
      .id()
      .field("name", .string, .required)
      .field("photos", .string)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("category-food").delete()
  }
}
