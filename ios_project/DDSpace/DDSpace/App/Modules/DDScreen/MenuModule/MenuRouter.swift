//
//  MenuRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import UIKit

final class MenuRouter {
    weak var navigationController: UINavigationController?
}

extension MenuRouter: MenuRouterInput {
    func goToDetailFood(food: FoodModel) {
        let foodDetail = FoodDetailContainer.assemble(with: FoodDetailContext(food: food))
        navigationController?.pushViewController(foodDetail.viewController, animated: false)
    }
    
    func goToCart() {
        let cartContainer = FoodCartContainer.assemble(with: FoodCartContext())
        navigationController?.pushViewController(cartContainer.viewController, animated: false)
    }
}
