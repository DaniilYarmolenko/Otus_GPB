//
//  CoreDataPageInteractor.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class CoreDataPageInteractor {
	weak var output: CoreDataPageInteractorOutput?
}

extension CoreDataPageInteractor: CoreDataPageInteractorInput {
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
    
        let count = CoreDataService.shared.fetchAll().count
        UserDefaults.standard.set(count, forKey: "countCoreData")
        NotificationCenter.default.post(name: NSNotification.Name("coreData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("coreData_delete"), object: nil)
        getCoreDataItems()
    }
    
    func deleteAll() {
        CoreDataService.shared.deleteAll()
        let count = 0
        UserDefaults.standard.set(count, forKey: "countCoreData")
        NotificationCenter.default.post(name: NSNotification.Name("coreData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("coreData_delete"), object: nil)
        getCoreDataItems()
    }
    
}
