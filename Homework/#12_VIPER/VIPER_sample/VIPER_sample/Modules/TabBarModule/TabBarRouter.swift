//
//  TabBarRouter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class TabBarRouter {
    private var views = [UIViewController]()
}

extension TabBarRouter: TabBarRouterInput {
    func getViews() -> [UIViewController] {
        views = [
            ColorsContainer.assemble(with: ColorsContext()).viewController,
            CartContainer.assemble(with: CartContext()).viewController
        ]
        return views
    }
    
}
