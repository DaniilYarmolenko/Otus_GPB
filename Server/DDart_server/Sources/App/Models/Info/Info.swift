//
//  Info.swift
//  
//
//  Created by Даниил Ярмоленко on 12.11.2022.
//

import Vapor
import Fluent

final class Info: Model {
    static let schema = "info"
    
    @ID
    var id: UUID?
    
    @Field(key: "phoneNumber")
    var phoneNumber: [String]
    @Field(key: "email")
    var email: String
    @Field(key: "address")
    var address: String
    @OptionalField(key: "vk")
    var vk: String?
    @OptionalField(key: "instagram")
    var instagram: String?
    @OptionalField(key: "telegram")
    var telegram: String?
    @Field(key: "longitude")
    var longitude: String
    @Field(key: "latitude")
    var latitude: String
    init() {}
    
    init(id: UUID? = nil, phoneNumber: [String], email: String, address: String, vk: String? = nil, instagram: String? = nil, telegram: String? = nil, longitude: String, latitude: String) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.vk = vk
        self.instagram =  instagram
        self.telegram = telegram
        self.longitude = longitude
        self.latitude = latitude
    }
}

extension Info: Content {}
