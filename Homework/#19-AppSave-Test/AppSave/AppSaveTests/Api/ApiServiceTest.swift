//
//  ApiServiceTest.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//

import XCTest
@testable import AppSave

final class ApiServiceTest: XCTestCase {
    
    func testRequest() {
        ApiMockService.shared.requestMock { result in
            switch result {
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
            case .success(let data):
                print(data)
                XCTAssertEqual(data.count, 1, "mock data count should be 1, but it's  \(data.count)")
                XCTAssertEqual(data.first!.id, "584", "mock data id should be 584, but it's  \(data.first!.id)")
                XCTAssertEqual(data.first!.url, "https://cdn2.thecatapi.com/images/584.gif", "mock data id should be 584, but it's  \(data.first!.url)")
                XCTAssertEqual(data.first!.width, 500, "mock data id should be 584, but it's  \(data.first!.width)")
                XCTAssertEqual(data.first!.height, 432, "mock data id should be 584, but it's  \(data.first!.height)")
            }
        }
    }
}
