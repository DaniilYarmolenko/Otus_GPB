//
//  UserController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor

struct UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoute = routes.grouped("api", "users")
        //        usersRoute.get(use: getAllHandler)
        //        usersRoute.get(":userID", use: getHandler)
        usersRoute.post("new", use: createHandler)
        let basicAuthMiddleware = User.authenticator()
        let basicAuthGroup = usersRoute.grouped(basicAuthMiddleware)
        basicAuthGroup.post("login", use: loginHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = usersRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenAuthGroup.get("eventTokens", use: getEventsTokenHandler)
        tokenAuthGroup.put(use: updateUserHandler)
    }
    //MARK: Create user
    func createHandler(_ req: Request) throws -> EventLoopFuture<User.Public> {
        let user = try req.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password)
        return user.save(on: req.db).map { user.convertToPublic() }
    }
    
    //MARK: Update user data
    func updateUserHandler(_ req: Request) throws -> EventLoopFuture<User> {
        let updateData = try req.content.decode(CreateUserData.self)
        let user = try req.auth.require(User.self)
        user.username = updateData.username
        user.firstName = updateData.firstName
        user.lastName = updateData.lastName
        user.photos = updateData.photos
        return user.save(on: req.db).map {user}
    }
    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let requestUser = try req.auth.require(User.self)
        guard requestUser.userType == .admin else {
            throw Abort(.forbidden)
        }
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
        //    func changeEmailUser(_ req: Request){}
        //MARK: Get all user data
        //    func getAllHandler(_ req: Request) -> EventLoopFuture<[User.Public]> {
        //        User.query(on: req.db).all().convertToPublic()
        //    }
        //
        //MARK: GetUserData
        //    func getHandler(_ req: Request) -> EventLoopFuture<User.Public> {
        //        User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).convertToPublic()
        //    }
        
        //MARK: Get all events token Handler
        func getEventsTokenHandler(_ req: Request) throws -> EventLoopFuture<[EventToken]> {
            let user = try req.auth.require(User.self)
            return user.$eventTokens.get(on: req.db)
        }
        
        //MARK: login handler
        func loginHandler(_ req: Request) throws -> EventLoopFuture<Token> {
            let user = try req.auth.require(User.self)
            let token = try Token.generate(for: user)
            return token.save(on: req.db).map { token }
        }
    }
    
    struct CreateUserData: Content {
        let firstName: String
        let lastName: String
        let username: String
        let photos: [String]?
    }
    struct CreateUserAdminData: Content {
        let addminStatus: Bool
    }
    struct CreateUserEmailData: Content {
        let email: String
    }
