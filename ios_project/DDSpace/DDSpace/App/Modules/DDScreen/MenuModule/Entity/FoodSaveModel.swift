//
//  FoodSaveModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.01.2023.
//

import Foundation
final class FoodSaveModel: Codable{
    var id: String
    var data: Data
    var nameFood: String
    var count: Int
    var cost: Int
    
    init(id: String, nameFood: String, data: Data, count: Int, cost: Int) {
        self.id = id
        self.nameFood = nameFood
        self.data = data
        self.count = count
        self.cost = cost
    }
}
