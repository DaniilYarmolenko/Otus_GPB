//
//  NewsDetailContainer.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class NewsDetailContainer {
    let input: NewsDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: NewsDetailRouterInput!

	class func assemble(with context: NewsDetailContext) -> NewsDetailContainer {
        let router = NewsDetailRouter()
        let interactor = NewsDetailInteractor()
        let presenter = NewsDetailPresenter(router: router, interactor: interactor)
		let viewController = NewsDetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.news = context.news
		interactor.output = presenter

        return NewsDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: NewsDetailModuleInput, router: NewsDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct NewsDetailContext {
	weak var moduleOutput: NewsDetailModuleOutput?
    var news: NewsModel
}
