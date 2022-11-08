//
//  User.swift
//  
//
//  Created by Даниил Ярмоленко on 06.11.2022.
//

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID
    var id: UUID?
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "email")
    var email: String
    
    @OptionalField(key: "photos")
    var photos: [String]?
    
    @Field(key: "password")
    var password: String
    
    @Enum(key: "userType")
    var userType: UserType
    
    @Children(for: \.$user)
    var eventTokens: [EventToken]
    
    init() {}
    
    init(id: UUID? = nil, firstName: String, lastName: String, username: String, email: String, photo: [String]? = nil, password: String, userType: UserType = .standard) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.photos = photo
        self.username = username
        self.password = password
        self.userType = userType
    }
    
    final class Public: Content {
        var id: UUID?
        var firstName: String
        var lastName: String
        var username: String
        var email: String
        var photos: [String]?
        var userType: UserType
        init(id: UUID?, firstName: String, lastName: String, username: String, email: String, photo: [String]? = nil, userType: UserType) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.username = username
            self.email = email
            self.photos = photo
            self.userType = userType
        }
    }
}

extension User {
    func convertToPublic() -> User.Public {
        return User.Public(id: id, firstName: firstName, lastName: lastName, username: username, email: email, photo: photos, userType: userType)
    }
}

extension EventLoopFuture where Value: User {
    func convertToPublic() -> EventLoopFuture<User.Public> {
        return self.map { user in
            return user.convertToPublic()
        }
    }
}

extension Collection where Element: User {
    func convertToPublic() -> [User.Public] {
        return self.map { $0.convertToPublic() }
    }
}

extension EventLoopFuture where Value == Array<User> {
    func convertToPublic() -> EventLoopFuture<[User.Public]> {
        return self.map { $0.convertToPublic() }
    }
}

extension User: ModelAuthenticatable {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}

extension User: ModelSessionAuthenticatable {}
extension User: ModelCredentialsAuthenticatable {}

enum UserType: String, Codable {
    case admin
    case standard
    case restricted
}
