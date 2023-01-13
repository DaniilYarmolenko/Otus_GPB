//
//  Token.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 16.12.2022.
//

import Foundation

final class Token: Codable {
    var id: UUID?
    var value: String
    
    init(value: String) {
        self.value = value
    }
}
