//
//  WebsiteController.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor

struct WebsiteController: RouteCollection {
    
    let imageFolderEvent = "Public/Pictures/EventPictures/"
    let imageFolderCategories = "Public/Pictures/CategoriesPictures/"
    let imageFolderFood = "Public/Pictures/FoodPictures/"
    let imageFolderFoodCategories = "Public/Pictures/FoodCategoriesPictures/"
    
    func boot(routes: RoutesBuilder) throws {
        //MARK: Login
        let authSessionsRoutes = routes.grouped(User.sessionAuthenticator())
        authSessionsRoutes.get("login", use: loginHandler)
        let credentialsAuthRoutes = authSessionsRoutes.grouped(User.credentialsAuthenticator())
        credentialsAuthRoutes.post("login", use: loginPostHandler)
        authSessionsRoutes.post("logout", use: logoutHandler)
        let protectedRoutes = authSessionsRoutes.grouped(User.redirectMiddleware(path: "/login"))
        //MARK: Events
        protectedRoutes.get(use: indexHandler)
        protectedRoutes.get("events", ":eventID", use: eventHandler)
        protectedRoutes.get("events", "create", use: createEventHandler)
        protectedRoutes.on(.POST, "events", "create", body: .collect(maxSize: "10mb"), use: createNewEventPostHandler)
        protectedRoutes.post("events", ":eventID", "delete", use: deleteEventHandler)
        protectedRoutes.get("events", ":eventID", "edit", use: editEventHandler)
        protectedRoutes.on(.POST, "events", ":eventID", "edit", body: .collect(maxSize: "10mb"), use: editEventPostHandler)
        
        
        //MARK: Events categories
        protectedRoutes.get("categories", use: allCategoriesHandler)
        protectedRoutes.get("categories",":categoryID", use: categoryHandler)
        protectedRoutes.post("categories", ":categoryID", "delete", use: deleteCategoryHandler)
        protectedRoutes.get("categories", ":categoryID", "edit", use: editCategoryHandler)
        protectedRoutes.on(.POST, "categories", ":categoryID", "edit", body: .collect(maxSize: "10mb"), use: editCategoryPostHandler)
        //MARK: Food
        protectedRoutes.get("foods", use: allFoodHandler)
        protectedRoutes.get("foods", ":foodID", use: foodHandler(_:))
        protectedRoutes.get("foods", "create", use: createFoodHandler)
        protectedRoutes.on(.POST, "foods", "create", body: .collect(maxSize: "10mb"), use: createNewFoodPostHandler)
        protectedRoutes.post("foods", ":foodID", "delete", use: deleteFoodHandler)
        protectedRoutes.get("foods", ":foodID", "edit", use: editFoodHandler)
        protectedRoutes.on(.POST, "foods", ":foodID", "edit", body: .collect(maxSize: "10mb"), use: editFoodPostHandler)
        //MARK: FoodCategories
        protectedRoutes.get("foodCategories", use: allFoodCategoriesHandler)
        protectedRoutes.get("foodCategories",":categoryFoodID", use: foodCategoryHandler)
        protectedRoutes.post("foodCategories", ":categoryFoodID", "delete", use: deleteFoodCategoryHandler)
        protectedRoutes.get("foodCategories", ":categoryFoodID", "edit", use: editFoodCategoryHandler)
        protectedRoutes.on(.POST, "foodCategories", ":categoryFoodID", "edit", body: .collect(maxSize: "10mb"), use: editFoodCategoryPostHandler)
        //MARK: AboutDD
    }
    //MARK: Login method
    //MARK: Login view
    func loginHandler(_ req: Request) -> EventLoopFuture<View> {
        let context: LoginContext
        if let error = req.query[Bool.self, at: "error"], error {
            context = LoginContext(loginError: true)
        } else {
            context = LoginContext()
        }
        return req.view.render("login", context)
    }
    //MARK: Login post
    func loginPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        do {
            _  =  try req.auth.require(User.self)
        } catch {
            let context = LoginContext(loginError: true)
            return req.view.render("login", context).encodeResponse(for: req)
        }
        let userReq = try req.auth.require(User.self)
        guard userReq.userType == .admin else {
            let context = LoginContext(loginError: true)
            return req.view.render("login", context).encodeResponse(for: req)
        }
        return req.eventLoop.future(req.redirect(to: "/"))
    }
    // MARK: Logout
    func logoutHandler(_ req: Request) -> Response {
        req.auth.logout(User.self)
        return req.redirect(to: "/")
        
    }
    
    //MARK: Event methods
    //MARK: Go to all event
    func indexHandler(_ req: Request) -> EventLoopFuture<View> {
        Event.query(on: req.db).all().flatMap { events in
            let userLoggedIn = req.auth.has(User.self)
            let showCookieMessage = req.cookies["cookies-accepted"] == nil
            let context = IndexContext(title: "Events", events: events, userLoggedIn: userLoggedIn, showCookieMessage: showCookieMessage)
            return req.view.render("index", context)
        }
    }
    
    //MARK: Get event info
    func eventHandler(_ req: Request) -> EventLoopFuture<View> {
        Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { event in
            let categoriesFuture = event.$categories.query(on: req.db).all()
            let eventTokensFuture = event.$eventTokens.query(on: req.db).all()
            return eventTokensFuture.and(categoriesFuture).flatMap { eventTokens, categories in
                let context = EventContext(
                    title: event.nameEvent,
                    event: event,
                    eventTokens: eventTokens,
                    categories: categories
                )
                return req.view.render("event", context)
            }
        }
    }
    
    //MARK: Create new event
    func createNewEventPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let data = try req.content.decode(CreateEventFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        let event = Event(id: UUID(), authorName: data.authorName, nameEvent: data.nameEvent, description: data.description, photos: [], dateStart: data.dateStart, dateEnd: data.dateEnd, eventType: data.eventType)
        guard let id = event.id else {
            return req.eventLoop.future(error: Abort(.internalServerError))
        }
        var uploadFutures = [EventLoopFuture<Void>]()
        if photo.files.first! != Data() {
            uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                let name = "\(id)-\(UUID()).jpg"
                let path = req.application.directory.workingDirectory + imageFolderEvent + name
                event.photos.append(name)
                return req.fileio.writeFile(.init(data: file), at: path)
            }
        }
        let redirect = req.redirect(to: "/events/\(id)")
        event.save(on: req.db).map {
            var categorySaves: [EventLoopFuture<Void>] = []
            for category in data.categories ?? [] {
                categorySaves.append(Category.addCategory(category, to: event, on: req))
            }
        }
        return req.eventLoop.flatten(uploadFutures).transform(to: redirect)
    }
    //MARK: page create event
    func createEventHandler(_ req: Request) -> EventLoopFuture<View> {
        let token = [UInt8].random(count: 16).base64
        let context = CreateEventContext(csrfToken: token)
        req.session.data["CSRF_TOKEN"] = token
        return req.view.render("createEvent", context)
    }
    
    //MARK: Delete event
    func deleteEventHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let event = try Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound))
        var photos = [String]()
        event.map { event in
            photos = event.photos
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderEvent + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
        }
        return Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { event in
                return event.delete(on: req.db).transform(to: req.redirect(to: "/"))
            }
    }
    
    //MARK: Create event update page
    func editEventHandler(_ req: Request) -> EventLoopFuture<View> {
        return Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { event in
            event.$categories.get(on: req.db).flatMap { categories in
                let context = EditEventContext(event: event, categories: categories)
                return req.view.render("createEvent", context)
            }
        }
    }
    
    //    //MARK: Edit event method
    func editEventPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let updateData = try req.content.decode(CreateEventFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        var photos = [String]()
        return Event.find(req.parameters.get("eventID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { event in
            event.authorName = updateData.authorName
            event.nameEvent = updateData.nameEvent
            event.description = updateData.description
            event.dateStart = updateData.dateStart
            event.dateEnd = updateData.dateEnd
            event.eventType = updateData.eventType
            photos = event.photos
            guard let id = event.id else {
                return req.eventLoop.future(error: Abort(.internalServerError))
            }
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderEvent + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
            event.photos = []
            var uploadFutures = [EventLoopFuture<Void>]()
            if photo.files.first != Data() {
                uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                    let name = "\(id)-\(UUID()).jpg"
                    let path = req.application.directory.workingDirectory + imageFolderEvent + name
                    event.photos.append(name)
                    return req.fileio.writeFile(.init(data: file), at: path)
                }
            }
            return event.save(on: req.db).flatMap {
                event.$categories.get(on: req.db)
            }.flatMap { existingCategories in
                let existingStringArray = existingCategories.map {
                    $0.name
                }
                
                let existingSet = Set<String>(existingStringArray)
                let newSet = Set<String>(updateData.categories ?? [])
                
                let categoriesToAdd = newSet.subtracting(existingSet)
                let categoriesToRemove = existingSet.subtracting(newSet)
                
                var categoryResults: [EventLoopFuture<Void>] = []
                for newCategory in categoriesToAdd {
                    categoryResults.append(Category.addCategory(newCategory, to: event, on: req))
                }
                
                for categoryNameToRemove in categoriesToRemove {
                    let categoryToRemove = existingCategories.first {
                        $0.name == categoryNameToRemove
                    }
                    if let category = categoryToRemove {
                        categoryResults.append(
                            event.$categories.detach(category, on: req.db))
                    }
                }
                categoryResults.append(contentsOf: uploadFutures)
                let redirect = req.redirect(to: "/events/\(id)")
                return categoryResults.flatten(on: req.eventLoop).transform(to: redirect)
            }
        }
    }
    
    
    //MARK: Categories methods
    //MARK: All categories page
    func allCategoriesHandler(_ req: Request) -> EventLoopFuture<View> {
        Category.query(on: req.db).all().flatMap { categories in
            let context = AllCategoriesContext(categories: categories)
            return req.view.render("allCategories", context)
        }
    }
    
    //MARK: Get category info
    func categoryHandler(_ req: Request) -> EventLoopFuture<View> {
        Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { category in
            category.$event.query(on: req.db).all().flatMap { events in
                let context = CategoryContext(title: category.name, events: events, category: category)
                return req.view.render("category", context)
            }
        }
    }
    
    //MARK: Delete category
    func deleteCategoryHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let category = try Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound))
        var photos = [String]()
        category.map { category in
            photos = category.photos
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderCategories + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
        }
        return Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { category in
                return category.delete(on: req.db).transform(to: req.redirect(to: "/"))
            }
    }
    //MARK: Edit category page
    func editCategoryHandler(_ req: Request) -> EventLoopFuture<View> {
        Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { category in
            let context = EditCategoryContext(category: category)
            return req.view.render("editCategory", context)
        }
    }
    //MARK: Edit category post request
    func editCategoryPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let updateData = try req.content.decode(CreateCategoryFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        var photos = [String]()
        return Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { category in
            category.name = updateData.name
            photos = category.photos
            guard let id = category.id else {
                return req.eventLoop.future(error: Abort(.internalServerError))
            }
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderCategories + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
            category.photos = []
            var uploadFutures = [EventLoopFuture<Void>]()
            if photo.files.first != Data() {
                uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                    let name = "\(id)-\(UUID()).jpg"
                    let path = req.application.directory.workingDirectory + imageFolderCategories + name
                    category.photos.append(name)
                    return req.fileio.writeFile(.init(data: file), at: path)
                }
            }
            let redirect = req.redirect(to: "/categories/\(id)")
            return category.save(on: req.db).transform(to: redirect)
        }
    }
    
   
    //MARK: Food methods
    //MARK: all Food page
    func allFoodHandler(_ req: Request) -> EventLoopFuture<View> {
        Food.query(on: req.db).all().flatMap { events in
            let userLoggedIn = req.auth.has(User.self)
            let showCookieMessage = req.cookies["cookies-accepted"] == nil
            let context = FoodsContext(title: "Foods", foods: events, userLoggedIn: userLoggedIn, showCookieMessage: showCookieMessage)
            return req.view.render("foods", context)
        }
    }
    
    //MARK: Get food info
    func foodHandler(_ req: Request) -> EventLoopFuture<View> {
        Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { food in
                food.$categoriesFood.query(on: req.db).all().flatMap { categories in
                let context = FoodContext(
                    title: food.nameFood,
                    food: food,
                    categories: categories
                )
                return req.view.render("foodPage", context)
            }
        }
    }
    
    //MARK: Create new Food Post Request
    func createNewFoodPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let data = try req.content.decode(CreateFoodFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        let food = Food(id: UUID(), nameFood: data.nameFood, cost: data.cost, description: data.description, photos: [])
        guard let id = food.id else {
            return req.eventLoop.future(error: Abort(.internalServerError))
        }
        var uploadFutures = [EventLoopFuture<Void>]()
        if photo.files.first! != Data() {
            uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                let name = "\(id)-\(UUID()).jpg"
                let path = req.application.directory.workingDirectory + imageFolderFood + name
                food.photos.append(name)
                return req.fileio.writeFile(.init(data: file), at: path)
            }
        }
        return food.save(on: req.db).flatMap {
            var categorySaves: [EventLoopFuture<Void>] = []
            for category in data.categoriesFood ?? [] {
                categorySaves.append(CategoryFood.addCategoryFood(category, to: food, on: req))
            }
            let redirect = req.redirect(to: "/foods/\(id)")
            return req.eventLoop.flatten(uploadFutures).transform(to: redirect)
        }
    }
    
    //MARK: Create food page
    func createFoodHandler(_ req: Request) -> EventLoopFuture<View> {
        let token = [UInt8].random(count: 16).base64
        let context = CreateFoodContext(csrfToken: token)
        req.session.data["CSRF_TOKEN"] = token
        return req.view.render("createFood", context)
    }
    
    //MARK: Delete food
    func deleteFoodHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let food = try Food.find(req.parameters.get("foodID"), on: req.db).unwrap(or: Abort(.notFound))
        var photos = [String]()
        food.map { food in
            photos = food.photos
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderFood + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
        }
        return Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { event in
                return event.delete(on: req.db).transform(to: req.redirect(to: "/foods"))
            }
    }
    
    //MARK: Create food update page
    func editFoodHandler(_ req: Request) -> EventLoopFuture<View> {
        return Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { food in
            food.$categoriesFood.get(on: req.db).flatMap { categoriesFood in
                let context = EditFoodContext(food: food, categoriesFood: categoriesFood)
                return req.view.render("createFood", context)
            }
        }
    }
    
    //    //MARK: Edit food POST method
    func editFoodPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let updateData = try req.content.decode(CreateFoodFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        var photos = [String]()
        return Food.find(req.parameters.get("foodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { food in
                food.nameFood = updateData.nameFood
                food.description = updateData.description
                food.cost = updateData.cost
                photos = food.photos
            guard let id = food.id else {
                return req.eventLoop.future(error: Abort(.internalServerError))
            }
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderFood + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
            food.photos = []
            var uploadFutures = [EventLoopFuture<Void>]()
            if photo.files.first != Data() {
                uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                    let name = "\(id)-\(UUID()).jpg"
                    let path = req.application.directory.workingDirectory + imageFolderFood + name
                    food.photos.append(name)
                    return req.fileio.writeFile(.init(data: file), at: path)
                }
            }
            return food.save(on: req.db).flatMap {
                food.$categoriesFood.get(on: req.db)
            }.flatMap { existingCategories in
                let existingStringArray = existingCategories.map {
                    $0.name
                }
                
                let existingSet = Set<String>(existingStringArray)
                let newSet = Set<String>(updateData.categoriesFood ?? [])
                
                let categoriesToAdd = newSet.subtracting(existingSet)
                let categoriesToRemove = existingSet.subtracting(newSet)
                
                var categoryResults: [EventLoopFuture<Void>] = []
                for newCategory in categoriesToAdd {
                    categoryResults.append(CategoryFood.addCategoryFood(newCategory, to: food, on: req))
                }
                
                for categoryNameToRemove in categoriesToRemove {
                    let categoryToRemove = existingCategories.first {
                        $0.name == categoryNameToRemove
                    }
                    if let category = categoryToRemove {
                        categoryResults.append(
                            food.$categoriesFood.detach(category, on: req.db))
                    }
                }
                categoryResults.append(contentsOf: uploadFutures)
                let redirect = req.redirect(to: "/foods/\(id)")
                return categoryResults.flatten(on: req.eventLoop).transform(to: redirect)
            }
        }
    }
    
    
    //MARK: Food Categories methods
    //MARK: All Food categories page
    func allFoodCategoriesHandler(_ req: Request) -> EventLoopFuture<View> {
        CategoryFood.query(on: req.db).all().flatMap { categories in
            let context = AllFoodCategoriesContext(categories: categories)
            return req.view.render("allFoodCategories", context)
        }
    }
    
    //MARK: Get Food category info
    func foodCategoryHandler(_ req: Request) -> EventLoopFuture<View> {
        CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { categoryFood in
                categoryFood.$foods.query(on: req.db).all().flatMap { foods in
                    let context = FoodCategoryContext(title: categoryFood.name, foods: foods, categoryFood: categoryFood)
                return req.view.render("categoryFood", context)
            }
        }
    }
    
    //MARK: Delete  FoodCategory
    func deleteFoodCategoryHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let categoryFood = try CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        var photos = [String]()
        categoryFood.map { categoryFood in
            photos = categoryFood.photos
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderFoodCategories + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
        }
        return CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { categoryFood in
                return categoryFood.delete(on: req.db).transform(to: req.redirect(to: "/foodCategories"))
            }
    }
    
    
    //MARK: Edit FoodCategory pagee
    func editFoodCategoryHandler(_ req: Request) -> EventLoopFuture<View> {
        CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { categoryFood in
            let context = EditFoodCategoryContext(categoryFood: categoryFood)
            return req.view.render("editFoodCategory", context)
        }
    }
    //MARK: Edit category post request
    func editFoodCategoryPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let updateData = try req.content.decode(CreateFoodCategoryFormData.self)
        let photo = try req.content.decode(ImageUploadData.self)
        var photos = [String]()
        return CategoryFood.find(req.parameters.get("categoryFoodID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { categoryFood in
                categoryFood.name = updateData.name
                photos = categoryFood.photos
            guard let id = categoryFood.id else {
                return req.eventLoop.future(error: Abort(.internalServerError))
            }
            photos.forEach { photo in
                let filepath = req.application.directory.workingDirectory + imageFolderFoodCategories + photo
                do {
                    try FileManager.default.removeItem(atPath: filepath)
                }
                catch {
                    print(error)
                }
            }
                categoryFood.photos = []
            var uploadFutures = [EventLoopFuture<Void>]()
            if photo.files.first != Data() {
                uploadFutures = photo.files.map { file -> EventLoopFuture<Void> in
                    let name = "\(id)-\(UUID()).jpg"
                    let path = req.application.directory.workingDirectory + imageFolderFoodCategories + name
                    categoryFood.photos.append(name)
                    return req.fileio.writeFile(.init(data: file), at: path)
                }
            }
            let redirect = req.redirect(to: "/foodCategories/\(id)")
            return categoryFood.save(on: req.db).transform(to: redirect)
        }
    }
}


//MARK: Login context
struct LoginContext: Encodable {
    let title = "Log In"
    let loginError: Bool
    
    init(loginError: Bool = false) {
        self.loginError = loginError
    }
}
//MARK: Events context
struct IndexContext: Encodable {
    let title: String
    let events: [Event]
    let userLoggedIn: Bool
    let showCookieMessage: Bool
}

struct EventContext: Encodable {
    let title: String
    let event: Event
    let eventTokens: [EventToken]
    let categories: [Category]
}
struct CreateEventContext: Encodable {
    let title = "Create event"
    let csrfToken: String
}
struct CreateEventFormData: Content {
    let authorName: String
    let nameEvent: String
    let description: String
    let dateStart: String
    let dateEnd: String
    var eventType: EventType = .admin
    let categories: [String]?
    let csrfToken: String?
}
struct EditEventContext: Encodable {
    let title = "Edit event"
    let event: Event
    let editing = true
    let categories: [Category]
}
//MARK: Categories context
struct AllCategoriesContext: Encodable {
    let title = "Event Categories"
    let categories: [Category]
}

struct CategoryContext: Encodable {
    let title: String
    let events: [Event]
    let category: Category
    
}
struct EditCategoryContext: Encodable {
    let title = "Edit event"
    let category: Category
}
struct CreateCategoryFormData: Content {
    let name: String
    let events: [String]?
    let csrfToken: String?
}

//MARK: Food context
struct FoodsContext: Encodable {
    let title: String
    let foods: [Food]
    let userLoggedIn: Bool
    let showCookieMessage: Bool
}
struct FoodContext: Encodable {
    let title: String
    let food: Food
    let categories: [CategoryFood]
}
struct CreateFoodFormData: Content {
    let nameFood: String
    let description: String
    var cost: Int
    let categoriesFood: [String]?
    let csrfToken: String?
}
struct CreateFoodContext: Encodable {
    let title = "Create food"
    let csrfToken: String
}
struct EditFoodContext: Encodable {
    let title = "Edit food"
    let food: Food
    let editing = true
    let categoriesFood: [CategoryFood]
}
//MARK: Food Categories context
struct AllFoodCategoriesContext: Encodable {
    let title = "Food Categories"
    let categories: [CategoryFood]
}

struct FoodCategoryContext: Encodable {
    let title: String
    let foods: [Food]
    let categoryFood: CategoryFood
    
}
struct EditFoodCategoryContext: Encodable {
    let title = "Edit food"
    let categoryFood: CategoryFood
}
struct CreateFoodCategoryFormData: Content {
    let name: String
    let foods: [String]?
    let csrfToken: String?
}
//MARK: Image content
struct ImageUploadData: Content {
    var files: [Data]
}

//    authSessionsRoutes.get("register", use: registerHandler)
//    authSessionsRoutes.post("register", use: registerPostHandler)
//
//    authSessionsRoutes.get(use: indexHandler)
//    authSessionsRoutes.get("acronyms", ":acronymID", use: acronymHandler)
//    authSessionsRoutes.get("users", ":userID", use: userHandler)
//    authSessionsRoutes.get("users", use: allUsersHandler)
//    authSessionsRoutes.get("categories", use: allCategoriesHandler)
//    authSessionsRoutes.get("categories", ":categoryID", use: categoryHandler)
//

//    protectedRoutes.get("acronyms", "create", use: createAcronymHandler)
//    protectedRoutes.post("acronyms", "create", use: createAcronymPostHandler)
//    protectedRoutes.get("acronyms", ":acronymID", "edit", use: editAcronymHandler)
//    protectedRoutes.post("acronyms", ":acronymID", "edit", use: editAcronymPostHandler)
//    protectedRoutes.post("acronyms", ":acronymID", "delete", use: deleteAcronymHandler)
//  }
//
//  func indexHandler(_ req: Request) -> EventLoopFuture<View> {
//    Acronym.query(on: req.db).all().flatMap { acronyms in
//      let userLoggedIn = req.auth.has(User.self)
//      let showCookieMessage = req.cookies["cookies-accepted"] == nil
//      let context = IndexContext(title: "Home page", acronyms: acronyms, userLoggedIn: userLoggedIn, showCookieMessage: showCookieMessage)
//      return req.view.render("index", context)
//    }
//  }
//
//  func acronymHandler(_ req: Request) -> EventLoopFuture<View> {
//    Acronym.find(req.parameters.get("acronymID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { acronym in
//      let userFuture = acronym.$user.get(on: req.db)
//      let categoriesFuture = acronym.$categories.query(on: req.db).all()
//      return userFuture.and(categoriesFuture).flatMap { user, categories in
//        let context = AcronymContext(
//          title: acronym.short,
//          acronym: acronym,
//          user: user,
//          categories: categories)
//        return req.view.render("acronym", context)
//      }
//    }
//  }
//
//  func userHandler(_ req: Request) -> EventLoopFuture<View> {
//    User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { user in
//      user.$acronyms.get(on: req.db).flatMap { acronyms in
//        let context = UserContext(title: user.name, user: user, acronyms: acronyms)
//        return req.view.render("user", context)
//      }
//    }
//  }
//
//  func allUsersHandler(_ req: Request) -> EventLoopFuture<View> {
//    User.query(on: req.db).all().flatMap { users in
//      let context = AllUsersContext(
//        title: "All Users",
//        users: users)
//      return req.view.render("allUsers", context)
//    }
//  }
//
//  func allCategoriesHandler(_ req: Request) -> EventLoopFuture<View> {
//    Category.query(on: req.db).all().flatMap { categories in
//      let context = AllCategoriesContext(categories: categories)
//      return req.view.render("allCategories", context)
//    }
//  }
//
//  func categoryHandler(_ req: Request) -> EventLoopFuture<View> {
//    Category.find(req.parameters.get("categoryID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { category in
//      category.$acronyms.get(on: req.db).flatMap { acronyms in
//        let context = CategoryContext(title: category.name, category: category, acronyms: acronyms)
//        return req.view.render("category", context)
//      }
//    }
//  }
//
//  func createAcronymHandler(_ req: Request) -> EventLoopFuture<View> {
//    let token = [UInt8].random(count: 16).base64
//    let context = CreateAcronymContext(csrfToken: token)
//    req.session.data["CSRF_TOKEN"] = token
//    return req.view.render("createAcronym", context)
//  }
//
//  func createAcronymPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
//    let data = try req.content.decode(CreateAcronymFormData.self)
//    let user = try req.auth.require(User.self)
//
//    let expectedToken = req.session.data["CSRF_TOKEN"]
//    req.session.data["CSRF_TOKEN"] = nil
//    guard
//      let csrfToken = data.csrfToken,
//      expectedToken == csrfToken
//    else {
//      throw Abort(.badRequest)
//    }
//
//    let acronym = try Acronym(short: data.short, long: data.long, userID: user.requireID())
//    return acronym.save(on: req.db).flatMap {
//      guard let id = acronym.id else {
//        return req.eventLoop.future(error: Abort(.internalServerError))
//      }
//      var categorySaves: [EventLoopFuture<Void>] = []
//      for category in data.categories ?? [] {
//        categorySaves.append(Category.addCategory(category, to: acronym, on: req))
//      }
//      let redirect = req.redirect(to: "/acronyms/\(id)")
//      return categorySaves.flatten(on: req.eventLoop).transform(to: redirect)
//    }
//  }
//

//
//  func editAcronymPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
//    let user = try req.auth.require(User.self)
//    let userID = try user.requireID()
//    let updateData = try req.content.decode(CreateAcronymFormData.self)
//    return Acronym.find(req.parameters.get("acronymID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { acronym in
//      acronym.short = updateData.short
//      acronym.long = updateData.long
//      acronym.$user.id = userID
//      guard let id = acronym.id else {
//        return req.eventLoop.future(error: Abort(.internalServerError))
//      }
//      return acronym.save(on: req.db).flatMap {
//        acronym.$categories.get(on: req.db)
//      }.flatMap { existingCategories in
//        let existingStringArray = existingCategories.map {
//          $0.name
//        }
//
//        let existingSet = Set<String>(existingStringArray)
//        let newSet = Set<String>(updateData.categories ?? [])
//
//        let categoriesToAdd = newSet.subtracting(existingSet)
//        let categoriesToRemove = existingSet.subtracting(newSet)
//
//        var categoryResults: [EventLoopFuture<Void>] = []
//        for newCategory in categoriesToAdd {
//          categoryResults.append(Category.addCategory(newCategory, to: acronym, on: req))
//        }
//
//        for categoryNameToRemove in categoriesToRemove {
//          let categoryToRemove = existingCategories.first {
//            $0.name == categoryNameToRemove
//          }
//          if let category = categoryToRemove {
//            categoryResults.append(
//              acronym.$categories.detach(category, on: req.db))
//          }
//        }
//
//        let redirect = req.redirect(to: "/acronyms/\(id)")
//        return categoryResults.flatten(on: req.eventLoop).transform(to: redirect)
//      }
//    }
//  }
//
//
//
//
//  func registerHandler(_ req: Request) -> EventLoopFuture<View> {
//    let context: RegisterContext
//    if let message = req.query[String.self, at: "message"] {
//      context = RegisterContext(message: message)
//    } else {
//      context = RegisterContext()
//    }
//    return req.view.render("register", context)
//  }
//
//  func registerPostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
//    do {
//      try RegisterData.validate(content: req)
//    } catch let error as ValidationsError {
//      let message = error.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Unknown error"
//      return req.eventLoop.future(req.redirect(to: "/register?message=\(message)"))
//    }
//    let data = try req.content.decode(RegisterData.self)
//    let password = try Bcrypt.hash(data.password)
//    let user = User(
//      name: data.name,
//      username: data.username,
//      password: password)
//    return user.save(on: req.db).map {
//      req.auth.login(user)
//      return req.redirect(to: "/")
//    }
//  }
//}
//
//struct IndexContext: Encodable {
//  let title: String
//  let acronyms: [Acronym]
//  let userLoggedIn: Bool
//  let showCookieMessage: Bool
//}
//
//struct AcronymContext: Encodable {
//  let title: String
//  let acronym: Acronym
//  let user: User
//  let categories: [Category]
//}
//
//struct UserContext: Encodable {
//  let title: String
//  let user: User
//  let acronyms: [Acronym]
//}
//
//struct AllUsersContext: Encodable {
//  let title: String
//  let users: [User]
//}
//
//struct AllCategoriesContext: Encodable {
//  let title = "All Categories"
//  let categories: [Category]
//}
//
//struct CategoryContext: Encodable {
//  let title: String
//  let category: Category
//  let acronyms: [Acronym]
//}
//
//struct CreateAcronymContext: Encodable {
//  let title = "Create An Acronym"
//  let csrfToken: String
//}
//
//struct EditAcronymContext: Encodable {
//  let title = "Edit Acronym"
//  let acronym: Acronym
//  let editing = true
//  let categories: [Category]
//}
//
//struct CreateAcronymFormData: Content {
//  let short: String
//  let long: String
//  let categories: [String]?
//  let csrfToken: String?
//}
//
//
//struct RegisterContext: Encodable {
//  let title = "Register"
//  let message: String?
//
//  init(message: String? = nil) {
//    self.message = message
//  }
//}
//
//struct RegisterData: Content {
//  let name: String
//  let username: String
//  let password: String
//  let confirmPassword: String
//}
//
//extension RegisterData: Validatable {
//  public static func validations(_ validations: inout Validations) {
//    validations.add("name", as: String.self, is: .ascii)
//    validations.add("username", as: String.self, is: .alphanumeric && .count(3...))
//    validations.add("password", as: String.self, is: .count(8...))
//    validations.add("zipCode", as: String.self, is: .zipCode, required: false)
//  }
//}
//
//extension ValidatorResults {
//  struct ZipCode {
//    let isValidZipCode: Bool
//  }
//}
//
//extension ValidatorResults.ZipCode: ValidatorResult {
//  var isFailure: Bool {
//    !isValidZipCode
//  }
//
//  var successDescription: String? {
//    "is a valid zip code"
//  }
//
//  var failureDescription: String? {
//    "is not a valid zip code"
//  }
//}
//
//extension Validator where T == String {
//  private static var zipCodeRegex: String {
//    "^\\d{5}(?:[-\\s]\\d{4})?$"
//  }
//
//  public static var zipCode: Validator<T> {
//    Validator { input -> ValidatorResult in
//      guard
//        let range = input.range(of: zipCodeRegex, options: [.regularExpression]),
//        range.lowerBound == input.startIndex && range.upperBound == input.endIndex
//      else {
//        return ValidatorResults.ZipCode(isValidZipCode: false)
//      }
//      return ValidatorResults.ZipCode(isValidZipCode: true)
//    }
//  }
//}
