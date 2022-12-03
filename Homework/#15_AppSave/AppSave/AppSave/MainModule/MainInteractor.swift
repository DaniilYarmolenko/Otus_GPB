//
//  MainInteractor.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class MainInteractor {
    weak var output: MainInteractorOutput?
    private var serviceAddToCoreData: ServiceCoreDataInput?
    private var serviceAddToCacheData: ServiceCacheDataInput?
    private var saveModel: ImageSaveModel?
    private var apiModel: ImageApiModel?
    init() {
        serviceAddToCoreData = CoreDataService.shared
        serviceAddToCacheData = CacheDataService.shared
    }
}


extension MainInteractor: MainInteractorInput {
    func loadData() {
        ApiSevice.shared.request { [weak self] result in
            switch result{
            case .failure:
                print("LOGIC Get data interactor error")
                break
            case .success(let data):
                self?.apiModel = data
                self?.output?.receiveModel(model: data)
            }
        }
    }
    
    func addToCache(model: ImageSaveModel, selected: Bool) {
        var count = UserDefaults.standard.integer(forKey: "countCacheData")
        if  selected {
            serviceAddToCacheData?.delete(with: model.name)
        }
        if !selected {
            serviceAddToCacheData?.insert(with: model)
        }
        count = serviceAddToCacheData?.fetchAll().count ?? 0
        UserDefaults.standard.set(count, forKey: "countCacheData")
        NotificationCenter.default.post(name: NSNotification.Name("cacheData"), object: nil)
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
    
    func addToCoreData(model: ImageSaveModel, selected: Bool) {
        var count = UserDefaults.standard.integer(forKey: "countCoreData")
        if  selected {
            serviceAddToCoreData?.delete(with: model.name)
        }
        if !selected {
            serviceAddToCoreData?.insert(with: model)
        }
        count = serviceAddToCoreData?.fetchAll().count ?? 0
        UserDefaults.standard.set(count, forKey: "countCoreData")
        NotificationCenter.default.post(name: NSNotification.Name("coreData"), object: nil)
    }
    
    func inCoreData(name: String) -> Bool {
        guard let serviceAddCoreData = serviceAddToCoreData else { return false }
        return serviceAddCoreData.isContain(with: name)
    }
    
    func inCacheData(name: String) -> Bool {
        guard let serviceAddToCacheData = serviceAddToCacheData else { return false }
        return serviceAddToCacheData.isContain(with: name)
    }
}
