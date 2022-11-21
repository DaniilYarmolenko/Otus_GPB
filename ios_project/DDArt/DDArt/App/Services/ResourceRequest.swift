//
//  ResourceRequest.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 15.11.2022.
//

import Foundation

let apiHostname = "http://localhost:8080"

class ResourceRequest<ResourceType> where ResourceType: Codable {
  let baseURL = "\(apiHostname)/api/"
  let resourceURL: URL

  init(resourcePath: String) {
    guard let resourceURL = URL(string: baseURL) else {
      fatalError("Failed to convert baseURL to a URL")
    }
    self.resourceURL =
      resourceURL.appendingPathComponent(resourcePath)
  }

  func getAll(completion: @escaping (Result<[ResourceType], ResourceRequestError>) -> Void) {
    let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noData))
        return
      }
      do {
        let resources = try JSONDecoder().decode([ResourceType].self, from: jsonData)
        completion(.success(resources))
      } catch {
        completion(.failure(.decodingError))
      }
    }
    dataTask.resume()
  }
}
