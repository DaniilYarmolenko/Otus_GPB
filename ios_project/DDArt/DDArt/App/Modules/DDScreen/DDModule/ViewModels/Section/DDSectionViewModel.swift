//
//  DDSectionViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation

final class DDSectionViewModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    var actions: TableViewCellOutput?
    
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
        print("LOGIC ROWS \(rows)")
    }
    
    init() {
        rows = [CellIdentifiable]()
        rows.append(HeaderCellViewModel(title: TitlesConstants.NewsTitle, action: {
            self.actions?.tapMoreNews()
        }))
        
        rows.append(HeaderCellViewModel(title: TitlesConstants.MenuTitle, action: {
            self.actions?.tapMoreFood()
        }))

        rows.append(HeaderCellViewModel(title: TitlesConstants.InfoTitle, action: nil))
    }
}
