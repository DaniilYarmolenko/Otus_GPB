//
//  CreateInfo.swift
//  
//
//  Created by Даниил Ярмоленко on 12.11.2022.
//

import Foundation
import Fluent

struct CreateInfo: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("info")
      .id()
      .field("phoneNumber", .array(of: .string), .required)
      .field("email", .string, .required)
      .field("address", .string, .required)
      .field("vk", .string)
      .field("instagram", .string)
      .field("telegram", .string)
      .field("longitude", .string, .required)
      .field("latitude", .string, .required)
      .create()
      
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("info").delete()
  }
}
