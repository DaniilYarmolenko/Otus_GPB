//
//  TestCoreData.swift
//  DDArtTests
//
//  Created by Даниил Ярмоленко on 08.01.2023.
//

import XCTest
import CoreData
@testable import DDSpace

final class TestCoreData: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoreData() throws {
        CoreDataService.shared.deleteAll()
        
        let food1 = FoodSaveModel(id: "firstID", nameFood: "firstName", data: Data(), count: 1, cost: 200)
        let food2 = FoodSaveModel(id: "secondID", nameFood: "secondName", data: Data(), count: 1, cost: 300)
        CoreDataService.shared.insert(with: food1)
        var dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 1, "core data count should be 1, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore.first!.id, "firstID", "core data name should be first, but it's  \(dataInCore.first!.id)")
        
        CoreDataService.shared.insert(with: food2)
        dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 2, "core data count should be 2, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore[1].id, "secondID", "core data name should be second, but it's  \(dataInCore[1].id)")
        
        
        XCTAssertEqual(CoreDataService.shared.isContain(with: "firstID"), true, "core data should be contain with name first, but it's  \(CoreDataService.shared.isContain(with: "firstID"))")
        
        XCTAssertEqual(CoreDataService.shared.isContain(with: "thirdID"), false, "core data shouldn't contain with name Random, but it's  \(CoreDataService.shared.isContain(with: "thirdID"))")
        
        
        CoreDataService.shared.delete(with: "firstID")
        dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 1, "core data count should be 1, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore[0].id, "secondID", "core data name should be second, but it's  \(dataInCore[0].id)")
        CoreDataService.shared.deleteAll()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
