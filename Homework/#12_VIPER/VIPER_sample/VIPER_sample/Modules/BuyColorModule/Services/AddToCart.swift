//
//  AddToCart.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import Foundation
import CoreData

final class ServiceAddCart: ServiceAddCartInput {
    
    static let shared = ServiceAddCart()
    private var dataManager: DataManagerDescription = DataManager.shared
    
    private init() {
        dataManager.initCoreData {
        }
    }
    
    func isContain(with id: Int) -> Bool {
        let fetchRequest = Cart.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let count = self.dataManager.fetch(with: fetchRequest)?.count
        return count != 0
    }
    
    func fetchAll() -> [Cart] {
        let objects = self.dataManager.fetch(with: Cart.fetchRequest())
        guard let objects = objects else { return [] }
        return objects
    }
    
    func delete(with id: Int) {
        self.dataManager.delete(with: "Cart") {
            let fetchRequest = Cart.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }

    func deleteAll() {
        self.dataManager.delete(with: "Cart") {
            let fetchRequest = Cart.fetchRequest()
            guard let fetchRequest = fetchRequest as? NSFetchRequest<NSManagedObject> else { return NSFetchRequest<NSManagedObject>() }
            return fetchRequest
        }
    }
    
    func insert(with model: ColorDetailModel) {
        self.dataManager.create(with: "Cart") { item in
            guard let cart = item as? Cart else {
                return
            }
            
            cart.id = Int32(model.id)
            cart.red = Float(model.red)
            cart.green = Float(model.green)
            cart.blue = Float(model.blue)

        }
    }
}
