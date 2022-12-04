//
//  ImageModel.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
import CoreData

public class ImageCoreModel: NSManagedObject {
}
extension ImageCoreModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCoreModel> {
        return NSFetchRequest<ImageCoreModel>(entityName: "Image")
    }
    @NSManaged public var id: String
    @NSManaged public var data: Data
    @NSManaged public var name: String
    @NSManaged public var urlString: String
}

extension ImageCoreModel: Identifiable {
}

