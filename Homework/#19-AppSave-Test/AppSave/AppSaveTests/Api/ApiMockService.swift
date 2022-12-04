//
//  CatRequestMock.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//

import Foundation
@testable import AppSave

class ApiMockService {
    
    static let shared = ApiMockService()
    private var path: String {
        guard let path = Bundle.main.path(forResource: "CatMock", ofType: "json") else { return "" }
        return path
    }
    func requestMock(completion: @escaping (Result<ImageApiModel, ResourceRequestError>)->Void){
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            do {
                let resources = try JSONDecoder().decode(ImageApiModel.self, from: jsonData)
                completion(.success(resources))
            } catch {
                completion(.failure(.decodingError))
            }
        } catch {
            completion(.failure(.noData))
            return
        }
        
    }
}
