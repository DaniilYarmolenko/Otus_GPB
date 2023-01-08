//
//  ImageModel.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
import CoreData

public class CartCoreModel: NSManagedObject {
}
extension CartCoreModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartCoreModel> {
        return NSFetchRequest<CartCoreModel>(entityName: "CartFood")
    }
    @NSManaged public var id: String
    @NSManaged public var data: Data
    @NSManaged public var name: String
    @NSManaged public var cost: Int32
    @NSManaged public var count: Int16
}

extension CartCoreModel: Identifiable {
}

