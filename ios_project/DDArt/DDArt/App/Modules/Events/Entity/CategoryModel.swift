//
//  Category.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class CategoryModel: Codable {
    var id: UUID?
    var name: String
    var photos: [String]
    init(name: String, photos: [String]) {
        self.name = name
        self.photos = photos
    }
}
