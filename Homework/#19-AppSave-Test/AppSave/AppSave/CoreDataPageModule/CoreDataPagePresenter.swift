//
//  CoreDataPagePresenter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class CoreDataPagePresenter {
	weak var view: CoreDataPageViewInput?
    weak var moduleOutput: CoreDataPageModuleOutput?
    var array = [ImageSaveModel]()
	private let router: CoreDataPageRouterInput
	private let interactor: CoreDataPageInteractorInput

    init(router: CoreDataPageRouterInput, interactor: CoreDataPageInteractorInput) {
        self.router = router
        self.interactor = interactor
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAllFromAlert), name: NSNotification.Name("DeleteAllCoreDataItems"), object: nil)
    }
}

extension CoreDataPagePresenter: CoreDataPageModuleInput {
}

extension CoreDataPagePresenter: CoreDataPageViewOutput {
    func filteringDataByName(with string: String) {
        interactor.filterDataByName(with: string)
    }
    
    
    func viewDidLoad() {
        interactor.getCoreDataItems()
    }
    
    func checkEmpty() -> Bool {
        array.isEmpty
    }
    
    func getCell(id: Int) -> ImageSaveModel? {
        return array[id]
    }
    
    func delete(name: String) {
        interactor.deleteBy(with: name)
    }
    
    func getCellsCount() -> Int {
        array.count
    }
    
    func deleteAll() {
        router.goToDeleteAlert(from: view)
    }
    @objc
    func deleteAllFromAlert() {
        interactor.deleteAll()
    }
}

extension CoreDataPagePresenter: CoreDataPageInteractorOutput {
    func receiveCoreDataItems(images: [ImageSaveModel]) {
        array = images
        view?.loadData()
    }
    
}
