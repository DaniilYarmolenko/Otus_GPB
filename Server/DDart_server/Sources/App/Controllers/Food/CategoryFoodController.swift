//
//  CategoryFoodController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//


import Vapor

struct CategoriesFoodController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categoriesRoute = routes.grouped("api", "foodCategories")
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.get(":categoryFoodID", use: getHandler)
        categoriesRoute.get(":categoryFoodID", "food", use: getFoodHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = categoriesRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenAuthGroup.post(use: createHandler)
    }
    
    // MARK: Create category food - admin
    func createHandler(_ req: Request) throws -> EventLoopFuture<CategoryFood> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {return req.eventLoop.makeFailedFuture(Abort(.forbidden))}
        let category = try req.content.decode(CategoryFood.self)
        return category.save(on: req.db).map { category}
        }
    // MARK: get all categoryFood
    func getAllHandler(_ req: Request) -> EventLoopFuture<[CategoryFood]> {
        CategoryFood.query(on: req.db).all()
    }
    //MARK: get category food by id
    func getHandler(_ req: Request) -> EventLoopFuture<CategoryFood> {
        CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db).unwrap(or: Abort(.notFound))
    }
    // MARK: get all food by categoryFoodID
    func getFoodHandler(_ req: Request) -> EventLoopFuture<[Food]> {
        CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { category in
                category.$foods.get(on: req.db)
            }
    }
}
