//
//  HeaderCellViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
final class HeaderCellViewModel: CellIdentifiable {
    var cellHeight: Float {
        return -1
    }
    
    typealias ActionHandler = () -> Void
    var action: ActionHandler?

    var cellIdentifier: String {
        return HeaderCellView.cellIdentifier
    }

    var title: String
    var seeAll: String

    init(title: String, action: ActionHandler? = nil) {
        self.title = title
        self.seeAll = TitlesConstants.MoreBarTitle
        self.action = action
    }
}
