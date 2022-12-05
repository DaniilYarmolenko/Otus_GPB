//
//  UserDefaultPresenterTest.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//


import XCTest
@testable import AppSave

final class UserDefaultsPagePresenterTest: XCTestCase {
    
    
    var presenter: UserDefaultsPagePresenter!
    var interactor: TestDefaultsPageInteractor!
    var router: TestDefaultsPageRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestDefaultsPageInteractor()
        router = TestDefaultsPageRouter()
        presenter = UserDefaultsPagePresenter(router: router, interactor: interactor)
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
        CacheDataService.shared.deleteAll()
        guard let url = Bundle.main.url(forResource: "CatMock", withExtension: "json") else {
            print("Errror")
            return
        }

        guard let data = try? Data(contentsOf:  url, options: .mappedIfSafe) else {return}
        let cat1 = ImageSaveModel(id: "first", url: "randomUrlString", data: data, name: "randomFirst")
        let cat2 = ImageSaveModel(id: "second", url: "randomUrlString", data: data, name: "randomSecond")
        CacheDataService.shared.insert(with: cat1)
        CacheDataService.shared.insert(with: cat2)

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
extension UserDefaultsPagePresenterTest {
    class TestDefaultsPageRouter: UserDefaultsPageRouterInput {
        var showAlert = false
        func goToDeleteAlert(from vc: AppSave.UserDefaultsPageViewInput?) {
            showAlert = true
            CacheDataService.shared.deleteAll()
        }
    }
    
    
    class TestDefaultsPageInteractor: UserDefaultsPageInteractorInput {
        weak var output: UserDefaultsPageInteractorOutput?
        func getCacheDataItems() {
            let cacheDataItems = CacheDataService.shared.fetchAll()
            let models = cacheDataItems.map { data in
                let model = ImageSaveModel(id: data.id , url: data.url, data: data.data, name: data.name)
                return model
            }
            output?.receiveCacheDataItems(images: models)
        }
        
        func deleteBy(with name: String) {
            CacheDataService.shared.delete(with: name)
            NotificationCenter.default.post(name: NSNotification.Name("cacheData"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("cacheData_delete"), object: nil)
            getCacheDataItems()
        }
        
        func deleteAll() {
            CacheDataService.shared.deleteAll()
            getCacheDataItems()
        }
        
        func filterDataByName(with string: String) {
            let cacheDataItems = CacheDataService.shared.fetchAll()
            var models = cacheDataItems.map { data in
                let model = ImageSaveModel(id: data.id , url: data.url, data: data.data, name: data.name)
                return model
            }
            if !string.isEmpty {
                models = models.filter{$0.name.contains(string)}
            }
            output?.receiveCacheDataItems(images: models)
        }
    }
    
}
