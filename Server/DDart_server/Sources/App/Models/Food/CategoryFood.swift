//
//  CategoryFood.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

//
//  Category.swift
//
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
import Vapor

final class CategoryFood: Model, Content {
    static let schema = "category-food"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "photo")
    var photo: String?
    
    @Siblings(through: FoodCategoryPivot.self, from: \.$categoryFood, to: \.$food)
    var foods: [Food]
    
    init() {}
    
    init(id: UUID? = nil, name: String, photo: String? = nil) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}

extension CategoryFood {
    static func addCategoryFood(_ name: String, to food: Food, on req: Request) -> EventLoopFuture<Void> {
        CategoryFood.query(on: req.db)
            .filter(\.$name == name)
            .first()
            .flatMap { foundCategory in
                if let existingCategory = foundCategory {
                    return food.$categoriesFood
                        .attach(existingCategory, on: req.db)
                } else {
                    let categoryFood = CategoryFood(name: name)
                    return categoryFood.save(on: req.db).flatMap {
                        food.$categoriesFood
                            .attach(categoryFood, on: req.db)
                    }
                }
            }
    }
}
