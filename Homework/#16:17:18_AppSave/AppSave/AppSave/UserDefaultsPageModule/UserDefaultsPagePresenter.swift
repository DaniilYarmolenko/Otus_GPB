//
//  UserDefaultsPagePresenter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class UserDefaultsPagePresenter {
	weak var view: UserDefaultsPageViewInput?
    weak var moduleOutput: UserDefaultsPageModuleOutput?
    var array = [ImageSaveModel]()
	private let router: UserDefaultsPageRouterInput
	private let interactor: UserDefaultsPageInteractorInput

    init(router: UserDefaultsPageRouterInput, interactor: UserDefaultsPageInteractorInput) {
        self.router = router
        self.interactor = interactor
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAllFromAlert), name: NSNotification.Name("DeleteAllCacheDataItems"), object: nil)
    }
}

extension UserDefaultsPagePresenter: UserDefaultsPageModuleInput {
}

extension UserDefaultsPagePresenter: UserDefaultsPageViewOutput {
    func viewDidLoad() {
        interactor.getCacheDataItems()
    }
    
    func checkEmpty() -> Bool {
        return array.isEmpty
    }
    
    func getCell(id: Int) -> ImageSaveModel? {
        return array[id]
    }
    
    func delete(name: String) {
        interactor.deleteBy(with: name)
    }
    
    func getCellsCount() -> Int {
        return array.count
    }
    
    func deleteAll() {
        router.goToDeleteAlert(from: view)
    }
    
    func filteringDataByName(with string: String) {
        interactor.filterDataByName(with: string)
    }
    @objc
    func deleteAllFromAlert() {
        interactor.deleteAll()
    }
    
}

extension UserDefaultsPagePresenter: UserDefaultsPageInteractorOutput {
    func receiveCacheDataItems(images: [ImageSaveModel]) {
        array = images
        view?.loadData()
    }
    
}
