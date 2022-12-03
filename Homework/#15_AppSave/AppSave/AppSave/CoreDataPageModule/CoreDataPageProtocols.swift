//
//  CoreDataPageProtocols.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

protocol CoreDataPageModuleInput {
	var moduleOutput: CoreDataPageModuleOutput? { get }
}

protocol CoreDataPageModuleOutput: AnyObject {
}

protocol CoreDataPageViewInput: AnyObject {
    func  loadData()
}

protocol CoreDataCellOutput: AnyObject {
    func deleteData(with name: String)
}
protocol CoreDataPageViewOutput: AnyObject {
    func viewDidLoad()
    func checkEmpty() -> Bool
    func getCell(id: Int) -> ImageSaveModel?
    func delete(name: String)
    func getCellsCount() -> Int
    func deleteAll()
    func filteringDataByName(with string: String)
}

protocol CoreDataPageInteractorInput: AnyObject {
    func getCoreDataItems()
    func deleteBy(with name: String)
    func deleteAll()
    func filterDataByName(with string: String)
}

protocol CoreDataPageInteractorOutput: AnyObject {
    func receiveCoreDataItems(images: [ImageSaveModel])
}

protocol CoreDataPageRouterInput: AnyObject {
    func goToDeleteAlert(from vc: CoreDataPageViewInput?)
}

//protocol ServiceCoreDataModelInput: AnyObject {
//    func loadItemsByNames(with name: [String])
//}
//
//protocol ServiceCoreDataModelOutput: AnyObject {
//    func itemDidLoad(colors: [ImageSaveModel])
//    func didFail(with error: Error)
//}
