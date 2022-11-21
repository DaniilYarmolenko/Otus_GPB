//
//  ResourceRequestError.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 15.11.2022.
//

import Foundation

enum ResourceRequestError: Error {
    case noData
    case decodingError
    case encodingError
}
