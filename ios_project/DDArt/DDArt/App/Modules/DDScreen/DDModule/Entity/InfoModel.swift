//
//  InfoModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
class InfoModel: Codable {
        var id: UUID?
        var phoneNumber: String
        var email: String
        var address: String
        var vk: String?
        var instagram: String?
        var telegram: String?
        var longitude: String
        var latitude: String
    init(id: UUID? = nil, phoneNumber: String, email: String, address: String, vk: String? = nil, instagram: String? = nil, telegram: String? = nil, longitude: String, latitude: String) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.vk = vk
        self.instagram = instagram
        self.telegram = telegram
        self.longitude = longitude
        self.latitude = latitude
    }
}
