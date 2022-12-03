//
//  CoreDataService.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
import CoreData

final class CoreDataService: ServiceCoreDataInput {
        
    
    static let shared = CoreDataService()
    private var dataManager: CoreDataManagerDescription = CoreDataManager.shared
    
    private init() {
        dataManager.initCoreData {
        }
    }
    
    func isContain(with name: String) -> Bool {
        let fetchRequest = ImageCoreModel.fetchRequest()
//        "\(#keyPath(Scene.relatedProject.name)) == %@", projectName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        let count = self.dataManager.fetch(with: fetchRequest)?.count
        return count != 0
    }
    
    func fetchAll() -> [ImageCoreModel] {
        let objects = self.dataManager.fetch(with: ImageCoreModel.fetchRequest())
        guard let objects = objects else { return [] }
        return objects
    }
    
    func delete(with id: String) {
        self.dataManager.delete(with: "Image") {
            let fetchRequest = ImageCoreModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", id)
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }

    func deleteAll() {
        self.dataManager.delete(with: "Image") {
            let fetchRequest = ImageCoreModel.fetchRequest()
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }
    
    func insert(with model: ImageSaveModel) {
            self.dataManager.create(with: "Image") { item in
                guard let item = item as? ImageCoreModel else {
                    return
                }
                item.id = model.id
                item.name = model.name
                item.data = model.data
                item.urlString = model.url
            }
        }
}
