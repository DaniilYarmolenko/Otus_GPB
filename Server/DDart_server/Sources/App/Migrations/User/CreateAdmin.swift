//
//  CreateAdmin.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
import Vapor

struct CreateAdminUser: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    let passwordHash: String
    do {
      passwordHash = try Bcrypt.hash("password")
    } catch {
      return database.eventLoop.future(error: error)
    }
      let user = User(firstName: "admin", lastName: "admin", username: "admin", email: "admin@email", password: passwordHash, userType: .admin)
    return user.save(on: database)
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    User.query(on: database).filter(\.$username == "admin").delete()
  }
}
