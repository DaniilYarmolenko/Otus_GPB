//
//  CategoryFoodModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class FoodCategory: Codable {
        var id: UUID?
        var name: String
        var photos: [String]
    init(id: UUID? = nil, name: String, photos: [String]) {
        self.id = id
        self.name = name
        self.photos = photos
    }
}
