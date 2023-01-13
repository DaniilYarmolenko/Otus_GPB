//
//  ServiceCoreData.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import CoreData

final class CoreDataService: ServiceCoreDataInput {
    
    
    static let shared = CoreDataService()
    private var dataManager = CoreDataCartManager.shared
    
    private init() {
        dataManager.initCoreData {
        }
    }
    func fetchCountCart(with id: String) -> Int {
        let fetchRequest = CartCoreModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let food = self.dataManager.fetch(with: fetchRequest)
        if let count = food?.first?.count {
            return Int(count)
        }
        return 0
    }
    
    func isContain(with id: String) -> Bool {
        let fetchRequest = CartCoreModel.fetchRequest()
        //        "\(#keyPath(Scene.relatedProject.name)) == %@", projectName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let count = self.dataManager.fetch(with: fetchRequest)?.count
        return count != 0
    }
    
    func fetchAll() -> [CartCoreModel] {
        let objects = self.dataManager.fetch(with: CartCoreModel.fetchRequest())
        guard let objects = objects else { return [] }
        return objects
    }
    func delete(with id: String) {
        self.dataManager.delete(with: "CartFood") {
            let fetchRequest = CartCoreModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }
    
    func deleteAll() {
        self.dataManager.delete(with: "CartFood") {
            let fetchRequest = CartCoreModel.fetchRequest()
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }
    
    func insert(with model: FoodSaveModel) {
        self.dataManager.create(with: "CartFood") { item in
            guard let item = item as? CartCoreModel else {
                return
            }
            item.id = model.id
            item.name = model.nameFood
            item.data = model.data
            item.count = Int16(model.count)
            item.cost = Int32(model.cost)
        }
    }
    func update(with model: FoodSaveModel) {
        let fetchRequest = CartCoreModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id)
        let food = self.dataManager.fetch(with: fetchRequest)
        food?.first?.count = Int16(model.count)
        food?.first?.cost = Int32(model.cost)
        food?.first?.name = model.nameFood
        try? self.dataManager.storeContainer.viewContext.save()
    }
}
