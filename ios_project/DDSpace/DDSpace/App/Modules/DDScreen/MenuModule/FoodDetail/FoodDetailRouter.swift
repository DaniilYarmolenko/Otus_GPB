//
//  FoodDetailRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodDetailRouter {
}

extension FoodDetailRouter: FoodDetailRouterInput {
    func goToCart(with view: FoodDetailViewInput?) {
        guard let view = view as? UIViewController, let navigation = view.navigationController else {return}
        let cartContainer = FoodCartContainer.assemble(with: FoodCartContext())
        navigation.pushViewController(cartContainer.viewController, animated: false)
    }
    
}
