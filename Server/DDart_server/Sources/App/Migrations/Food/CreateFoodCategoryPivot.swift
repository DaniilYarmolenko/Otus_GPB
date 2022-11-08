//
//  CreateFoodCategoryPivot.swift
//
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
struct CreateFoodCategoryPivot: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("food-category-pivot")
      .id()
      .field("foodID", .uuid, .required, .references("foods", "id", onDelete: .cascade))
      .field("categoryFoodID", .uuid, .required, .references("category-food", "id", onDelete: .cascade))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("food-category-pivot").delete()
  }
}
