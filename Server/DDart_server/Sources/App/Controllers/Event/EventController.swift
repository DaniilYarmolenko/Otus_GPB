//
//  EventController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor
import Fluent

struct EventController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let eventRoutes = routes.grouped("api", "events")
        eventRoutes.get(use: getAvailibleEventHandler)
        eventRoutes.get(":eventsID", use: getHandler)
        eventRoutes.get("search", use: searchHandler)
        eventRoutes.get("first", use: getFirstHandler)
        eventRoutes.get("sorted","name", use: sortedNameHandler)
        eventRoutes.get(":eventsID", "categories", use: getCategoriesHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthGroup = eventRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        tokenAuthGroup.get("admin", use: getAllHandler)
        tokenAuthGroup.post(use: createHandler)
        tokenAuthGroup.delete(":eventsID", use: deleteHandler)
        tokenAuthGroup.put(":eventsID", use: updateHandler)
        tokenAuthGroup.post(":eventsID", "categories", ":categoryID", use: addCategoriesHandler)
        tokenAuthGroup.delete(":eventsID", "categories", ":categoryID", use: removeCategoriesHandler)
        tokenAuthGroup.post("token", ":eventID", use: createTokenForEvent)
    }
    // MARK: Get all events
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[Event]> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden
                                                       ))
        }
        return Event.query(on: req.db).all()
    }
    func getAvailibleEventHandler(_ req: Request) -> EventLoopFuture<[Event]> {
        Event.query(on: req.db).filter(\.$eventType == .standard).all()
    }
    //MARK: Create events by admin
    func createHandler(_ req: Request) throws -> EventLoopFuture<Event> {
        let data = try req.content.decode(CreateEventData.self)
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden
                                                       ))
        }
        let event = Event(authorName: data.authorName, nameEvent: data.nameEvent, description: data.description, photos: data.photos, dateStart: data.dateStart, dateEnd: data.dateEnd
        )
        print("data end - \(data.dateEnd) data start - \(data.dateStart)")
        print("EVENT end = \(event.dateEnd) start = \(event.dateStart)")
        return event.save(on: req.db).map { event
        }
    }
    
    //MARK: get event by id
    func getHandler(_ req: Request) -> EventLoopFuture<Event> {
        Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    //MARK: update event by id
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Event> {
        let updateData = try req.content.decode(CreateEventData.self)
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { event in
                event.nameEvent = updateData.nameEvent
                event.authorName = updateData.authorName
                event.photos = updateData.photos
                event.dateStart = updateData.dateStart
                event.dateEnd = updateData.dateEnd
                event.description = updateData
                    .description
                return event.save(on: req.db).map { event
                }
            }
    }
    //MARK: Delete event by admin
    func deleteHandler(_ req: Request) throws
    -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                return event.delete(on: req.db)
                    .transform(to: HTTPStatus.noContent)
            }
    }
    //MARK: Search event by name
    func searchHandler(_ req: Request) throws -> EventLoopFuture<[Event]> {
        guard let search = req
            .query[String.self, at: "search"] else {
            throw Abort(.badRequest)
        }
        return Event.query(on: req.db).group(.or) { or in
            or.filter(\.$nameEvent == search)
            or.filter(\.$authorName == search)
        }.all()
    }
    
    //MARK: Get first event
    func getFirstHandler(_ req: Request) -> EventLoopFuture<Event> {
        return Event.query(on: req.db)
            .first()
            .unwrap(or: Abort(.notFound))
    }
    //MARK: Sorted by Time
    func sortedTimeHandler(_ req: Request) -> EventLoopFuture<[Event]> {
        return Event.query(on: req.db).sort(\.$dateEnd, .ascending).all()
    }
    //MARK: Sorted by Handler
    func sortedNameHandler(_ req: Request) -> EventLoopFuture<[Event]> {
        return Event.query(on: req.db).sort(\.$nameEvent, .ascending).all()
    }
    //MARK: get all tokens handler by admin
    func getEventTokensHandler(_ req: Request) throws -> EventLoopFuture<[EventToken]> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                event.$eventTokens.get(on: req.db)
            }
    }
    //MARK: Add categories by ADMIN
    func addCategoriesHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let user = try req.auth.require(User.self)
        guard user.userType == .admin else {
            return req.eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        let eventQuery = Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound))
        let categoryQuery = Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound))
        return eventQuery.and(categoryQuery).flatMap { event, category in
            event.$categories.attach(category, on: req.db).transform(to: .created)
        }
    }

    //MARK: Get categories for event
    func getCategoriesHandler(_ req: Request) -> EventLoopFuture<[Category]> {
        Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                event.$categories.query(on: req.db).all()
            }
    }
    
//MARK: remov eCategories for event by admin
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
    //MARK: Create token to eeveent from User
    
    func createTokenForEvent(_ req: Request) throws -> EventLoopFuture<EventToken> {
        let user = try req.auth.require(User.self)
        let userID = try user.requireID()
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                let value = "userID = \(userID) eventName = \(event.nameEvent)"
                do {
                   let eventToken = try EventToken(value: value, userID: userID, eventID: event.requireID())
                    return eventToken.save(on: req.db).map {eventToken}
                } catch let error{
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
            
    }
}

struct CreateEventData: Content {
    let authorName: String
    let nameEvent: String
    let description: String
    let dateStart: String
    let dateEnd: String
    let photos: [String]
}
