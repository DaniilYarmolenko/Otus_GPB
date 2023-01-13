//
//  NewsContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class NewsContainer {
    let input: NewsModuleInput
    let viewController: UIViewController
    private(set) weak var router: NewsRouterInput!
    
    class func assemble(with context: NewsContext) -> NewsContainer {
        let router = NewsRouter()
        let interactor = NewsInteractor()
        let presenter = NewsPresenter(router: router, interactor: interactor)
        let viewController = NewsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        presenter.news = context.news
        router.navigationController = context.navigationController
        interactor.output = presenter
        
        return NewsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: NewsModuleInput, router: NewsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct NewsContext {
    weak var moduleOutput: NewsModuleOutput?
    var news: [NewsModel]
    weak var navigationController: UINavigationController?
}
