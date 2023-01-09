//
//  User.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//

import Foundation

final class CreateUserData: Codable {
    var id: UUID?
    var firstName: String
    var lastName: String
    var username: String
    var password: String
    var email: String
    var userType: UserType
    var photos: [String]?
    
    init(firstName: String, lastName: String, username: String, email: String, photo: [String]? = nil, password: String, userType: UserType = .standard) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.photos = photo
        self.username = username
        self.password = password
        self.userType = userType
    }
}
final class User: Codable {
    var id: UUID?
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var userType: UserType
    var photos: [String]?
    
    init(firstName: String, lastName: String, username: String, email: String, photo: [String]? = nil, userType: UserType = .standard) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.photos = photo
        self.username = username
        self.userType = userType
    }
}

enum UserType: String, Codable {
    case standard
    case admin
    case restricted
}
