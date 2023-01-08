//
//  FoodModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class FoodModel: Codable {
        var id: UUID?
        var nameFood: String
        var description: String
        var photos: [String]
        var cost: Int
    init(id: UUID? = nil, nameFood: String, description: String, photos: [String], cost: Int) {
        self.id = id
        self.nameFood = nameFood
        self.description = description
        self.photos = photos
        self.cost = cost
    }
}
