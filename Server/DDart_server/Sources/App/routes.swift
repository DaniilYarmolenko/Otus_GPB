import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    let acronymsController = EventController()
    try app.register(collection: acronymsController)
    
    let usersController = UsersController()
    try app.register(collection: usersController)
    
    let categoriesController = CategoriesController()
    try app.register(collection: categoriesController)

    let foodController = FoodController()
    try app.register(collection: foodController)
    
    let categoriesFoodCollection = CategoriesFoodController()
    try app.register(collection: categoriesFoodCollection)
    let websiteController = WebsiteController()
    try app.register(collection: websiteController)
}
