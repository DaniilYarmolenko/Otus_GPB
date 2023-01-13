//
//  WelcomeContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import UIKit

final class WelcomeContainer {
    let input: WelcomeModuleInput
    let viewController: UIViewController
    private(set) weak var router: WelcomeRouterInput!
    
    class func assemble(with context: WelcomeContext) -> WelcomeContainer {
        let router = WelcomeRouter()
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter(router: router, interactor: interactor)
        let viewController = WelcomeViewController(output: presenter, transitionStyle:  UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return WelcomeContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: WelcomeModuleInput, router: WelcomeRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct WelcomeContext {
    weak var moduleOutput: WelcomeModuleOutput?
}
