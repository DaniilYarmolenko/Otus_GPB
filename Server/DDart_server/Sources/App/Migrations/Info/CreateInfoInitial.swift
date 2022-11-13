//
//  CreateInfoInitial.swift
//  
//
//  Created by Даниил Ярмоленко on 12.11.2022.
//


import Fluent
import Vapor

struct CreateInfoInitial: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
      
      let info = Info(phoneNumber: "+79162804297", email: "DaniilYarmolenko@gmail.com", address: "Moscow, Tverskaya str. 1", vk: "https://vk.com/daniilwisniewski", telegram: "t.me/ydmsu", longitude: "55.770076", latitude: "37.595079")
    return info.save(on: database)
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
      Info.query(on: database).delete()
  }
}
