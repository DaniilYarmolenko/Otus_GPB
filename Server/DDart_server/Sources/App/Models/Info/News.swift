//
//  News.swift
//  
//
//  Created by Даниил Ярмоленко on 12.11.2022.
//

import Vapor
import Fluent

final class News: Model {
    static let schema = "news"
    
    @ID
    var id: UUID?
    @Field(key: "titleNews")
    var titleNews: String
    
    @Field(key: "nameFood")
    var newsName: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "photos")
    var photos: [String]
    
    
    init() {}
    
    init(id: UUID? = nil, titleNews: String, newsName: String, description: String, photos: [String] = []) {
        self.id = id
        self.titleNews = titleNews
        self.newsName = newsName
        self.description = description
        self.photos = photos
    }
}

extension News: Content {}
