//
//  MainPresenterTest.swift
//  AppSaveTests
//
//  Created by Даниил Ярмоленко on 04.12.2022.
//

import XCTest
@testable import AppSave

final class MainPresenterTest: XCTestCase {
    
    var presenter: MainPresenter!
    var interactor: TestMainInteractor!
    var router: TestMainRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestMainInteractor()
        router = TestMainRouter()
        presenter = MainPresenter(router: router, interactor: interactor)
        interactor.output = presenter
    }
    func testThatItRetrievesCat() {
        presenter.getData()
        let model = presenter.model
        XCTAssertEqual(model?.count ?? 0, 1, "mock data count should be 1, but it's  \(model?.count ?? 0)")
        XCTAssertEqual(model?.first?.id ?? " ", "584", "mock data id should be 584, but it's  \(model?.first?.id ?? " ")")
        XCTAssertEqual(model?.first?.url ?? " ", "https://cdn2.thecatapi.com/images/584.gif", "mock data id should be 584, but it's  \(model?.first?.url ?? " ")")
        XCTAssertEqual(model?.first?.width ?? 0, 500, "mock data id should be 584, but it's  \(model?.first?.width ?? 0)")
        XCTAssertEqual(model?.first?.height ?? 0, 432, "mock data id should be 584, but it's  \(model?.first?.height ?? 0)")
    }
    
}
extension MainPresenterTest {
    class TestMainRouter: MainRouterInput {}
    
    
    class TestMainInteractor: MainInteractorInput {
        weak var output: MainInteractorOutput?
        private var apiModel: ImageApiModel?
        private var saveModel: ImageSaveModel?
        func loadData() {
            ApiMockService.shared.requestMock { result in
                switch result {
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
                case .success(let data):
                    self.apiModel = data
                    self.output?.receiveModel(model: data)
                }
            }
        }
        
        func getDataImage(url: String) -> Data? {
            var dataReturn = Data()
            guard let resourceURL = URL(string: url) else {
                return nil
            }
            ImageLoader.shared.getData(from: resourceURL) { data, _, _ in
                DispatchQueue.main.async {
                    dataReturn = data ?? Data()
                }
            }
            return dataReturn
        }
        
        func addToCoreData(model: AppSave.ImageSaveModel, selected: Bool) {
            if  selected {
                CacheDataService.shared.delete(with: model.name)
            }
            if !selected {
                CacheDataService.shared.insert(with: model)
            }
        }
        
        func addToCache(model: AppSave.ImageSaveModel, selected: Bool) {
            if  selected {
                CoreDataService.shared.delete(with: model.name)
            }
            if !selected {
                CoreDataService.shared.insert(with: model)
            }
        }
        
        func inCoreData(name: String) -> Bool {
            CoreDataService.shared.isContain(with: name)
        }
        
        func inCacheData(name: String) -> Bool {
            CacheDataService.shared.isContain(with: name)
            
        }
        
    }
    
}
