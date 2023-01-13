//
//  SigninContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import UIKit

final class SigninContainer {
    let input: SigninModuleInput
    let viewController: UIViewController
    private(set) weak var router: SigninRouterInput!
    
    class func assemble(with context: SigninContext) -> SigninContainer {
        let router = SigninRouter()
        let interactor = SigninInteractor()
        let presenter = SigninPresenter(router: router, interactor: interactor)
        let viewController = SigninViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return SigninContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SigninModuleInput, router: SigninRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SigninContext {
    weak var moduleOutput: SigninModuleOutput?
}
