//
//  FoodController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor
import Fluent

struct FoodController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let foodRoutes = routes.grouped("api", "foods")
        foodRoutes.get(use: getAllHandler)
        foodRoutes.get(":foodID", use: getHandler)
        foodRoutes.get("search", use: searchHandler)
        foodRoutes.get("first", use: getFirstHandler)
        foodRoutes.get("sorted","name", use: sortedNameHandler)
        foodRoutes.get(":foodID", "categories", use: getCategoriesHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = foodRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenAuthGroup.post(use: createHandler)
        tokenAuthGroup.delete(":foodID", use: deleteHandler)
        tokenAuthGroup.put(":foodID", use: updateHandler)
        tokenAuthGroup.post(":foodID", "categories", ":categoryID", use: addCategoriesHandler)
        tokenAuthGroup.delete(":foodID", "categories", ":categoryID", use: removeCategoriesHandler)
    }
    // MARK: Get all food
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Food]> {
        Food.query(on: req.db).all()
    }
    //MARK: Create food by admin
    func createHandler(_ req: Request) throws -> EventLoopFuture<Food> {
        let data = try req.content.decode(CreateFoodData.self)
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        let food = Food(nameFood: data.nameFood, cost: data.cost, description: data.description)
        return food.save(on: req.db).map { food
        }
    }
    
    //MARK: get food by id
    func getHandler(_ req: Request) -> EventLoopFuture<Food> {
        Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    //MARK: update food by id
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Food> {
        let updateData = try req.content.decode(CreateFoodData.self)
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.notAcceptable))
        }
        return Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { food in
                food.nameFood = updateData.nameFood
                food.cost = updateData.cost
                food.description = updateData.description
                return food.save(on: req.db).map { food
                }
            }
    }
    //MARK: Delete food by admin
    func deleteHandler(_ req: Request) throws
    -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { food in
                return food.delete(on: req.db)
                    .transform(to: HTTPStatus.noContent)
            }
    }
    //MARK: Search event by name
    func searchHandler(_ req: Request) throws -> EventLoopFuture<[Food]> {
        guard let search = req
            .query[String.self, at: "search"] else {
            throw Abort(.badRequest)
        }
        return Food.query(on: req.db).group(.or) { or in
            or.filter(\.$nameFood == search)
        }.all()
    }
    
    //MARK: Get first event
    func getFirstHandler(_ req: Request) -> EventLoopFuture<Food> {
        return Food.query(on: req.db)
            .first()
            .unwrap(or: Abort(.notFound))
    }
    //MARK: Sorted by Time
    func sortedCostHandler(_ req: Request) -> EventLoopFuture<[Food]> {
        return Food.query(on: req.db).sort(\.$cost, .ascending).all()
    }
    //MARK: Sorted by Handler
    func sortedNameHandler(_ req: Request) -> EventLoopFuture<[Food]> {
        return Food.query(on: req.db).sort(\.$nameFood, .ascending).all()
    }
    //MARK: Add categories by ADMIN
    func addCategoriesHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden
                                                       ))
        }
        let eventQuery = Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound))
        let categoryQuery = Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound))
        return eventQuery.and(categoryQuery).flatMap { event, category in
            event.$categories.attach(category, on: req.db).transform(to: .created)
        }
    }

    //MARK: Get categories for food
    func getCategoriesHandler(_ req: Request) -> EventLoopFuture<[Category]> {
        Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                event.$categories.query(on: req.db).all()
            }
    }
    
//MARK: remove Categories for food by admin
    func removeCategoriesHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        let eventQuery = Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound))
        let categoryQuery = Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound))
        return eventQuery.and(categoryQuery).flatMap { event, category in
            event.$categories.detach(category, on: req.db).transform(to: .noContent)
        }
    }
}

struct CreateFoodData: Content {
    let nameFood: String
    let description: String
    let photos: [String]?
    let cost: Int
}
