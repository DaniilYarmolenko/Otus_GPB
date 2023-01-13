//
//  DDSectionViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation

final class DDSectionViewModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    weak var actions: TableViewCellOutput?
    
    func fillData(news: [NewsModel], categoriesFood: [FoodCategory], info: [InfoModel], output: DDViewOutput) {
        rows.insert(
            NewsCollectionViewModel(array: news, action: { [weak self] index in
                self?.actions?.tapOnNews(with: index)
            })
            , at: 1)
        rows.insert(
            FoodCategoriesCollectionViewModel(array: categoriesFood, action: { [weak self] index in
                self?.actions?.tapOnCategory(with: index)
            })
            , at: 3)
        rows.append(InfoCollectionViewModel(model: info, action: nil, output: output))
    }
    
    init() {
        rows = [CellIdentifiable]()
        rows.append(HeaderCellViewModel(title: TitlesConstants.NewsTitle, action: { [weak self] in
            self?.actions?.tapMoreNews()
        }))
        
        rows.append(HeaderCellViewModel(title: TitlesConstants.MenuTitle, action: {  [weak self] in
            self?.actions?.tapMoreFood()
        }))
        
        rows.append(HeaderCellViewModel(title: TitlesConstants.InfoTitle, action: nil))
    }
}
