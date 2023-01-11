//
//  CoreDataPagePresenterTest.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//

import XCTest
@testable import AppSave

final class CoreDataPagePresenterTest: XCTestCase {
    
    
    var presenter: CoreDataPagePresenter!
    var interactor: TestCoreDataPageInteractor!
    var router: TestCoreDataPageRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestCoreDataPageInteractor()
        router = TestCoreDataPageRouter()
        presenter = CoreDataPagePresenter(router: router, interactor: interactor)
        interactor.output = presenter
    }
    func reloadImage(model: ImageApiModel) {
    }
    func testThatItRetrievesCacheData() throws {
        presenter.deleteAll()
        presenter.viewDidLoad()
        XCTAssertTrue(router.showAlert)
        XCTAssertEqual(presenter.array.isEmpty, true, "Cache data should be empty")
    }
    func testCountCell() {
        CoreDataService.shared.deleteAll()
        guard let url = Bundle.main.url(forResource: "CatMock", withExtension: "json") else {
            print("Errror")
            return
        }

        guard let data = try? Data(contentsOf:  url, options: .mappedIfSafe) else {return}
        let cat1 = ImageSaveModel(id: "first", url: "randomUrlString", data: data, name: "randomFirst")
        let cat2 = ImageSaveModel(id: "second", url: "randomUrlString", data: data, name: "randomSecond")
        CoreDataService.shared.insert(with: cat1)
        CoreDataService.shared.insert(with: cat2)

        presenter.viewDidLoad()
        var count = self.presenter.getCellsCount()
        XCTAssertEqual(count, 2, "Cell count should be 2")
        
        presenter.delete(name: "randomFirst")
        count = presenter.getCellsCount()
        XCTAssertEqual(count, 1, "Cell count should be 1")
        
        
        presenter.deleteAll()
        presenter.viewDidLoad()
        XCTAssertTrue(router.showAlert)
        count = presenter.getCellsCount()
        XCTAssertEqual(count, 0, "Cell count should be 0")
    }
    
    private func deleteAllCache(complition: @escaping ()->()) {
        presenter.deleteAll()
    }
    
    private func deleteByNameCache(name: String, complition: @escaping ()->()) {
        presenter.delete(name: name)
    }
}
extension CoreDataPagePresenterTest {
    class TestCoreDataPageRouter: CoreDataPageRouterInput {
        
        var showAlert = false
        func goToDeleteAlert(from vc: AppSave.CoreDataPageViewInput?) {
            showAlert = true
            CoreDataService.shared.deleteAll()
        }
        
    }
    
    
    class TestCoreDataPageInteractor: CoreDataPageInteractorInput {
        
        weak var output: CoreDataPageInteractorOutput?
        func getCoreDataItems() {
            let coreDataItems = CoreDataService.shared.fetchAll()
            let models = coreDataItems.map { data in
                let model = ImageSaveModel(id: data.id , url: data.urlString, data: data.data, name: data.name)
                return model
            }
            output?.receiveCoreDataItems(images: models)
        }
        
        func deleteBy(with name: String) {
            CoreDataService.shared.delete(with: name)
            getCoreDataItems()
        }
        
        func deleteAll() {
            CoreDataService.shared.deleteAll()
            getCoreDataItems()
        }
        
        func filterDataByName(with string: String) {
            let coreDataItems = CoreDataService.shared.fetchAll()
            var models = coreDataItems.map { data in
                let model = ImageSaveModel(id: data.id , url: data.urlString, data: data.data, name: data.name)
                return model
            }
            if !string.isEmpty {
                models = models.filter{$0.name.contains(string)}
            }
            output?.receiveCoreDataItems(images: models)
        }
    }
    
}
