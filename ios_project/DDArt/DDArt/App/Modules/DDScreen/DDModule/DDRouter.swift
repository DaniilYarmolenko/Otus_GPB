//
//  DDRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class DDRouter {
}

extension DDRouter: DDRouterInput {
    func categoryFoodSelected(with view: DDViewInput?, and id: Int, foodCategories: [FoodCategory]) {
        guard let view = view as? UIViewController, let navigationController = view.navigationController else { return }
        let menuContainer = MenuContainer.assemble(with: MenuContext(categoryFood: foodCategories, navigationController: navigationController, scrollSection: id))
        navigationController.pushViewController(menuContainer.viewController, animated: true)
    }
    
    
    func newsSelected(with view: DDViewInput?, news: NewsModel) {
        guard let view = view as? UIViewController, let navigationController = view.navigationController else { return }
        let newsDetail = NewsDetailContainer.assemble(with: NewsDetailContext(news: news))
        navigationController.pushViewController(newsDetail.viewController, animated: true)
    }
    
    func goToMenu(with view: DDViewInput?, foodCategory: [FoodCategory]) {
        guard let view = view as? UIViewController, let navigationController = view.navigationController else { return }
        let menuContainer = MenuContainer.assemble(with: MenuContext(categoryFood: foodCategory, navigationController: navigationController))
        navigationController.pushViewController(menuContainer.viewController, animated: true)
    }
    
    func goToAllNews(with view: DDViewInput?, news: [NewsModel]) {
        guard let view = view as? UIViewController, let navigationController = view.navigationController else { return }
        let newsContainer = NewsContainer.assemble(with: NewsContext(news: news, navigationController: navigationController))
        navigationController.pushViewController(newsContainer.viewController, animated: true)
    }
    
    func presentMap(with view: DDViewInput?) {
        
    }
    
}
