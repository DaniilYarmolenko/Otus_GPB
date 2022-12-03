//
//  ImageSaveModel.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
final class ImageSaveModel: BaseCellModel, Codable{
    var id: String
    var url: String
    var data: Data
    var name: String
    
    init(id: String, url: String, data: Data, name: String) {
        self.id = id
        self.url = url
        self.data = data
        self.name = name
    }
    override var cellIdentifier: String {
        return "ImageSaveCell"
    }
}
