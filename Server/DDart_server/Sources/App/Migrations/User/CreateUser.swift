//
//  CreateUser.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.enum("userType")
            .case("admin")
            .case("standard")
            .case("restricted")
            .create()
            .flatMap{ userType in
                database.schema("users")
                    .id()
                    .field("firstName", .string, .required)
                    .field("lastName", .string, .required)
                    .field("username", .string, .required)
                    .unique(on: "username")
                    .field("email", .string, .required)
                    .unique(on: "email")
                    .field("photos", .array(of: .string))
                    .field("password", .string, .required)
                    .field("userType", userType, .required)
                    .create()
            }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
