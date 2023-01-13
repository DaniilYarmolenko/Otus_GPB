//
//  FoodCartContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodCartContainer {
    let input: FoodCartModuleInput
    let viewController: UIViewController
    private(set) weak var router: FoodCartRouterInput!
    
    class func assemble(with context: FoodCartContext) -> FoodCartContainer {
        let router = FoodCartRouter()
        let interactor = FoodCartInteractor()
        let presenter = FoodCartPresenter(router: router, interactor: interactor)
        let viewController = FoodCartViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return FoodCartContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: FoodCartModuleInput, router: FoodCartRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct FoodCartContext {
    weak var moduleOutput: FoodCartModuleOutput?
}
