//
//  NewsCollectionViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//

import Foundation
final class NewsCollectionViewModel: CellIdentifiable {
    var cellHeight: Float {
        return Float(SizeConstants.screenHeight/4)
    }
    
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?
    
    var cellIdentifier: String {
        return NewsCollectionTableViewCell.cellIdentifier
    }
    
    var array: [NewsModel]
    
    init(array: [NewsModel], action: ActionHandler? = nil) {
        self.array = array
        self.action = action
    }
}
