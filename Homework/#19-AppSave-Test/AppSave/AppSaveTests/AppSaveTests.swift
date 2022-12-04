//
//  AppSaveTests.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//

import XCTest
import CoreData
@testable import AppSave

final class AppSaveTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testCoreData() throws {
        guard let url = Bundle.main.url(forResource: "CatMock", withExtension: "json") else {
            print("Errror")
            return
        }
        guard let data = try? Data(contentsOf:  url, options: .mappedIfSafe) else {
            XCTFail("Fail get data from assets")
            return
        }
        CoreDataService.shared.deleteAll()
        
        let cat1 = ImageSaveModel(id: "first", url: "randomUrlString", data: data, name: "randomFirst")
        let cat2 = ImageSaveModel(id: "second", url: "randomUrlString", data: data, name: "randomSecond")
        CoreDataService.shared.insert(with: cat1)
        var dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 1, "core data count should be 1, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore.first!.id, "first", "core data name should be first, but it's  \(dataInCore.first!.id)")
        
        CoreDataService.shared.insert(with: cat2)
        dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 2, "core data count should be 2, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore[1].id, "second", "core data name should be second, but it's  \(dataInCore[1].id)")
        
        
        XCTAssertEqual(CoreDataService.shared.isContain(with: "randomFirst"), true, "core data should be contain with name first, but it's  \(CoreDataService.shared.isContain(with: "randomFirst"))")
        XCTAssertEqual(CoreDataService.shared.isContain(with: "Random"), false, "core data shouldn't contain with name Random, but it's  \(CoreDataService.shared.isContain(with: "Random"))")
        
        
        CoreDataService.shared.delete(with: "randomFirst")
        dataInCore = CoreDataService.shared.fetchAll()
        XCTAssertEqual(dataInCore.count, 1, "core data count should be 1, but it's  \(dataInCore.count)")
        XCTAssertEqual(dataInCore[0].id, "second", "core data name should be second, but it's  \(dataInCore[0].id)")
        CoreDataService.shared.deleteAll()
    }
    
    func testCacheData() throws {
        guard let url = Bundle.main.url(forResource: "CatMock", withExtension: "json") else {
            print("Errror")
            return
        }
        guard let data = try? Data(contentsOf:  url, options: .mappedIfSafe) else {
            XCTFail("Fail get data from assets")
            return
        }
        CacheDataService.shared.deleteAll()
        
        let cat1 = ImageSaveModel(id: "first", url: "randomUrlString", data: data, name: "randomFirst")
        let cat2 = ImageSaveModel(id: "second", url: "randomUrlString", data: data, name: "randomSecond")
        CacheDataService.shared.insert(with: cat1)
        var dataInCache = CacheDataService.shared.fetchAll()
        XCTAssertEqual(dataInCache.count, 1, "core data count should be 1, but it's  \(dataInCache.count)")
        XCTAssertEqual(dataInCache.first?.id ?? " ", "first", "core data name should be first, but it's  \(dataInCache.first!.id)")
        
        CacheDataService.shared.insert(with: cat2)
        dataInCache = CacheDataService.shared.fetchAll()
        XCTAssertEqual(dataInCache.count, 2, "core data count should be 2, but it's  \(dataInCache.count)")
        XCTAssertEqual(dataInCache[1].id, "second", "core data name should be second, but it's  \(dataInCache[1].id)")
        
        
        XCTAssertEqual(CacheDataService.shared.isContain(with: "randomFirst"), true, "core data should be contain with name randomFirst, but it's  \(CacheDataService.shared.isContain(with: "randomFirst"))")
        XCTAssertEqual(CacheDataService.shared.isContain(with: "Random"), false, "core data shouldn't contain with name Random, but it's  \(CacheDataService.shared.isContain(with: "Random"))")
        
        
        CacheDataService.shared.delete(with: "randomFirst")
        dataInCache = CacheDataService.shared.fetchAll()
        XCTAssertEqual(dataInCache.count, 1, "core data count should be 1, but it's  \(dataInCache.count)")
        XCTAssertEqual(dataInCache[0].id, "second", "core data name should be second, but it's  \(dataInCache[0].id)")
        CacheDataService.shared.deleteAll()
    }

}
