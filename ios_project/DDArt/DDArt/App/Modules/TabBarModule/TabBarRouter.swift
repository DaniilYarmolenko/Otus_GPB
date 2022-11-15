//
//  TabBarRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class TabBarRouter {
    private var views = [UIViewController]()
}

extension TabBarRouter: TabBarRouterInput {
    func getViews() -> [UIViewController] {
        // Add  Views
        views = [
            EventsContainer.assemble(with: EventsContext()).viewController,
            DDContainer.assemble(with: DDContext()).viewController,
            ExtraScreenContainer.assemble(with: ExtraScreenContext()).viewController
        ]
        return views
    }
    
}
