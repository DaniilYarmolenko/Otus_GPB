//
//  Food.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Vapor
import Fluent

final class Food: Model {
    static let schema = "foods"
    
    @ID
    var id: UUID?
    
    @Field(key: "nameFood")
    var nameFood: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "photos")
    var photos: [String]
    
    @Field(key: "cost")
    var cost: String
    
    @Siblings(through: FoodCategoryPivot.self, from: \.$food, to: \.$categoryFood)
    var categoriesFood: [CategoryFood]
    
    init() {}
    
    init(id: UUID? = nil, nameFood: String, cost: String, description: String, photos: [String] = []) {
        self.id = id
        self.nameFood = nameFood
        self.cost = cost
        self.description = description
        self.photos = photos
    }
}

extension Food: Content {}
