//
//  News.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class NewsModel: Codable {
    var id: UUID?
    var titleNews: String
    var newsName: String
    var description: String
    var photos: [String]
    init(id: UUID? = nil, titleNews: String, newsName: String, description: String, photos: [String]) {
        self.id = id
        self.titleNews = titleNews
        self.newsName = newsName
        self.description = description
        self.photos = photos
    }
}
