//
//  ExtraScreenContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class ExtraScreenContainer {
    let input: ExtraScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: ExtraScreenRouterInput!
    
    class func assemble(with context: ExtraScreenContext) -> ExtraScreenContainer {
        let router = ExtraScreenRouter()
        let interactor = ExtraScreenInteractor()
        let presenter = ExtraScreenPresenter(router: router, interactor: interactor)
        let viewController = ExtraScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ExtraScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ExtraScreenModuleInput, router: ExtraScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ExtraScreenContext {
    weak var moduleOutput: ExtraScreenModuleOutput?
}
