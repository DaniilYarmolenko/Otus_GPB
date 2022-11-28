//
//  TabBarInteractor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class TabBarInteractor {
	weak var output: TabBarInteractorOutput?
}

extension TabBarInteractor: TabBarInteractorInput {
    func getTabBarItemsInfo() {
        output?.receiveTabBarItemsInfo(with: [
            TabBarItemModel(image: "collection", title: "Colors", selectedImage: "collection"),
            TabBarItemModel(image: "cart", title: "Cart", selectedImage: "cart")
        ])
    }
    
}
