//
//  EventRequest.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 15.11.2022.
//

import Foundation


struct EventRequest {
    let resource: URL

    init(eventID: UUID) {
      let resourceString = "\(apiHostname)/api/events/\(eventID)"
      guard let resourceURL = URL(string: resourceString) else {
        fatalError("Unable to createURL")
      }
      self.resource = resourceURL
    }

    func getCategories(completion: @escaping (Result<[CategoryEvent], ResourceRequestError>) -> Void) {
      let url = resource.appendingPathComponent("categories")
      let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let jsonData = data else {
          completion(.failure(.noData))
          return
        }
        do {
          let categories = try JSONDecoder().decode([CategoryEvent].self, from: jsonData)
          completion(.success(categories))
        } catch {
          completion(.failure(.decodingError))
        }
      }
      dataTask.resume()
    }
}
