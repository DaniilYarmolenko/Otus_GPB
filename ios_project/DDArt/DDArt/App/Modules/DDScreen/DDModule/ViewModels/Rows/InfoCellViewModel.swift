//
//  InfoCellViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
final class InfoCollectionViewModel: CellIdentifiable {
    var cellHeight: Float {
        return Float(SizeConstants.screenHeight/2)
    }
    
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    var cellIdentifier: String {
        return InfoViewCell.cellIdentifier
    }

    var infoModel: [InfoModel]

    init(model: [InfoModel], action: ActionHandler? = nil) {
        self.infoModel = model
        self.action = action
    }
}
