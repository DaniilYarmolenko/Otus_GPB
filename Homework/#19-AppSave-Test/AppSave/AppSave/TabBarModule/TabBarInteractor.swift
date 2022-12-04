//
//  TabBarInteractor.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class TabBarInteractor {
	weak var output: TabBarInteractorOutput?
}

extension TabBarInteractor: TabBarInteractorInput {
    func getTabBarItemsInfo() {
        output?.receiveTabBarItemsInfo(with: [
            TabBarItem(image: "main", title: "Main", selectedImage: "main"),
            TabBarItem(image: "coreData", title: "CoreData", selectedImage: "coreData"),
            TabBarItem(image: "UD", title: "User Defaults", selectedImage: "UD")
        ])
    }
}
