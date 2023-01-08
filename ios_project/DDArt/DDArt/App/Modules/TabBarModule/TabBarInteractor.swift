//
//  TabBarInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class TabBarInteractor {
	weak var output: TabBarInteractorOutput?
}

extension TabBarInteractor: TabBarInteractorInput {
    func getTabBarItemsInfo() {
        output?.receiveTabBarItemsInfo(with: [
            TabBarItemModel(image: "events", title: TitlesConstants.EventsBarTitle, selectedImage: "events"),
            TabBarItemModel(image: "ddMini", title: nil, selectedImage: "ddMini"),
            TabBarItemModel(image: "more", title: TitlesConstants.MoreBarTitle, selectedImage: "more")
        ]
        )
    }
    
}
