//
//  FoodCategoryPivot.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
import Foundation

final class FoodCategoryPivot: Model {
    static let schema = "food-category-pivot"
    
    @ID
    var id: UUID?
    
    @Parent(key: "foodID")
    var food: Food
    
    @Parent(key: "categoryFoodID")
    var categoryFood: CategoryFood
    
    init() {}
    
    init(id: UUID? = nil, food: Food, categoryFood: CategoryFood) throws {
        self.id = id
        self.$food.id = try food.requireID()
        self.$categoryFood.id = try categoryFood.requireID()
    }
}
