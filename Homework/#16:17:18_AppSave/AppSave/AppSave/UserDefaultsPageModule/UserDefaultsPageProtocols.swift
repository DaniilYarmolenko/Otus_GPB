//
//  UserDefaultsPageProtocols.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

protocol UserDefaultsPageModuleInput {
	var moduleOutput: UserDefaultsPageModuleOutput? { get }
}
protocol CacheDataCellOutput: AnyObject {
    func deleteData(with name: String)
}

protocol UserDefaultsPageModuleOutput: AnyObject {
}

protocol UserDefaultsPageViewInput: AnyObject {
    func  loadData()
}

protocol UserDefaultsPageViewOutput: AnyObject {
    func viewDidLoad()
    func checkEmpty() -> Bool
    func getCell(id: Int) -> ImageSaveModel?
    func delete(name: String)
    func getCellsCount() -> Int
    func deleteAll()
    func filteringDataByName(with string: String)
}

protocol UserDefaultsPageInteractorInput: AnyObject {
    func getCacheDataItems()
    func deleteBy(with name: String)
    func deleteAll()
    func filterDataByName(with string: String)
}

protocol UserDefaultsPageInteractorOutput: AnyObject {
    func receiveCacheDataItems(images: [ImageSaveModel])
}

protocol UserDefaultsPageRouterInput: AnyObject {
    func goToDeleteAlert(from vc: UserDefaultsPageViewInput?)
}
