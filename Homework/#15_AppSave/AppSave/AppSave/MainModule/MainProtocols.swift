//
//  MainProtocols.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
    var modelInput: ImageApiModel? { get set }
}

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
    func reloadImage(model: ImageApiModel)
}

protocol MainViewOutput: AnyObject {
    func getData()
    func addToCoreData(name: String, selected: Bool)
    func addToCache(name: String, selected: Bool)
    func inCoreData(name: String) -> Bool
    func inCacheData(name: String) -> Bool
}

protocol MainInteractorInput: AnyObject {
    func loadData()
    func getDataImage(url: String) -> Data?
    func addToCoreData(model: ImageSaveModel, selected: Bool)
    func addToCache(model: ImageSaveModel, selected: Bool)
    func inCoreData(name: String) -> Bool
    func inCacheData(name: String) -> Bool
}

protocol MainInteractorOutput: AnyObject {
    func receiveModel(model: ImageApiModel)
}

protocol MainRouterInput: AnyObject {
}
protocol ServiceCoreDataInput: AnyObject {
    func isContain(with name: String) -> Bool
    func delete(with id: String )
    func insert(with model: ImageSaveModel)
    func fetchAll() -> [ImageCoreModel]
    func deleteAll()
}
protocol ServiceCacheDataInput: AnyObject {
    func isContain(with name: String) -> Bool
    func delete(with id: String )
    func insert(with model: ImageSaveModel)
    func fetchAll() -> [ImageSaveModel]
    func deleteAll()
}
protocol ServiceManagerModelInput: AnyObject {
    func loadItemById(with id: Int)
}

protocol ServiceManagerModelOutput: AnyObject {
    func didFail(with error: Error)
}

protocol ModelRepresentable {
    var model: BaseCellModel? { get set }
}
