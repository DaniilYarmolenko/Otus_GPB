//
//  ModelData.swift
//  TableView_Homework
//
//  Created by Даниил Ярмоленко on 17.10.2022.
//

import Foundation

class ModelData {
    let cityNameLong: String
    let countryName: String
    let description: String
    let photo: String?
    
    init(cityNameLong: String, countryName: String, description: String, photo: String? = nil) {
        self.cityNameLong = cityNameLong
        self.countryName = countryName
        self.description = description
        self.photo = photo
    }
}
