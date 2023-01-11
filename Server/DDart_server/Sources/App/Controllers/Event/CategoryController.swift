//
//  CategoryController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor

struct CategoriesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categoriesRoute = routes.grouped("api", "categories")
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.get(":categoryID", use: getHandler)
        categoriesRoute.get(":categoryID", "events", use: getEventsHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = categoriesRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenAuthGroup.post(use: createHandler)
    }
    
    //MARK: Create category - admin
    func createHandler(_ req: Request) throws -> EventLoopFuture<Category> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {return req.eventLoop.makeFailedFuture(Abort(.forbidden))}
        let category = try req.content.decode(Category.self)
        return category.save(on: req.db).map{category}
        }
    // MARK: get all category
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Category]> {
        Category.query(on: req.db).all()
    }
    // MARK: get category by id
    func getHandler(_ req: Request) -> EventLoopFuture<Category> {
        Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound))
    }
    // MARK: get all events by categoryID
    func getEventsHandler(_ req: Request) -> EventLoopFuture<[Event]> {
        Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                event.$event.get(on: req.db)
            }
    }
}
