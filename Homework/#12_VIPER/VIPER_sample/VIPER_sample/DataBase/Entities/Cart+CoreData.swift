//
//  Cart+CoreData.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import Foundation
import CoreData

public class Cart: NSManagedObject {
}
extension Cart {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var id: Int32
    @NSManaged public var red: Float
    @NSManaged public var green: Float
    @NSManaged public var blue: Float
}

extension Cart: Identifiable {
}
