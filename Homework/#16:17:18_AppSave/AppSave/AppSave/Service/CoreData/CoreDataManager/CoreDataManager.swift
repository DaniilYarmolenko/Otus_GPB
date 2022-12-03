//
//  CoreDataManager.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerDescription {
    func initCoreData(complition: @escaping () -> Void)
    func fetch<T>(with request: NSFetchRequest<T>) -> [T]?
    func create<T: NSManagedObject>(with entityName: String, configBlock: (T) -> Void)
    func delete<T: NSManagedObject>(with entityName: String, configBlock: () -> NSFetchRequest<T>)
}

class CoreDataManager: CoreDataManagerDescription {
    private let modelName = "ImageModel"
    static let shared = CoreDataManager()
    private let storeContainer: NSPersistentContainer
    var mainQueueContext: NSManagedObjectContext {
        return storeContainer.viewContext
    }
    
    private init() {
        self.storeContainer = NSPersistentContainer(name: modelName)
    }
    
    func initCoreData(complition: @escaping () -> Void) {
        storeContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            complition()
        }
    }
    
    func fetch<T>(with request: NSFetchRequest<T>) -> [T]? {
        return try? storeContainer.viewContext.fetch(request)
    }
    
    func create<T>(with entityName: String, configBlock: (T) -> Void) where T: NSManagedObject {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: entityName, into: storeContainer.viewContext) as? T else { return }
        
        configBlock(obj)
        
        try? storeContainer.viewContext.save()
    }
    
    func delete<T>(with entityName: String, configBlock: () -> NSFetchRequest<T>) where T: NSManagedObject {
        let request = configBlock()
        let objects = fetch(with: request)
        guard let objects = objects else { return }
        for obj in objects {
            storeContainer.viewContext.delete(obj)
        }
        
        try? storeContainer.viewContext.save()
    }
}
