//
//  ApiService.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
let apiHostname = "http://daniilyarmolenko.fvds.ru/"

struct ApiService<ResourceType> where ResourceType: Codable {
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
//class ApiSevice {
//    static let shared = ApiSevice()
//    let url: URL
//    init() {
//        let baseURL = "https://api.thecatapi.com/v1/images/search"
//        guard let resourceURL = URL(string: baseURL) else {
//          fatalError("Unable to createURL")
//        }
//        self.url = resourceURL
//    }
//    func request(completion: @escaping (Result<ImageApiModel, ResourceRequestError>) -> Void) {
//        
//        let dataTask = URLSession.shared.dataTask(with: url) { data ,_,_ in
//            
//            guard let jsonData = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let resources = try JSONDecoder().decode(ImageApiModel.self, from: jsonData)
//                completion(.success(resources))
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }
//        dataTask.resume()
//    }
//}
