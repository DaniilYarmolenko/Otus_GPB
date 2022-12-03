//
//  UserDefaultsPageInteractor.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class UserDefaultsPageInteractor {
	weak var output: UserDefaultsPageInteractorOutput?
}

extension UserDefaultsPageInteractor: UserDefaultsPageInteractorInput {
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
        NotificationCenter.default.post(name: NSNotification.Name("cacheData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("cacheData_delete"), object: nil)
        getCacheDataItems()
    }
}
