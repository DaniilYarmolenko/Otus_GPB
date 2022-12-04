//
//  TabBarRouter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class TabBarRouter {
    private var views = [UIViewController]()
}

extension TabBarRouter: TabBarRouterInput {
    func getViews() -> [UIViewController] {
        views = [
            MainContainer.assemble(with: MainContext()).viewController,
            CoreDataPageContainer.assemble(with: CoreDataPageContext()).viewController,
            UserDefaultsPageContainer.assemble(with: UserDefaultsPageContext()).viewController
        ]
        return views
    }
}
