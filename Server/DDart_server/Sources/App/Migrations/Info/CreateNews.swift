//
//  CreateNews.swift
//  
//
//  Created by Даниил Ярмоленко on 12.11.2022.
//

import Foundation
import Fluent

struct CreateNews: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("news")
      .id()
      .field("titleNews", .string, .required)
      .field("newsName", .string, .required)
      .field("description", .string, .required)
      .field("photos", .array(of: .string), .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("news").delete()
  }
}
