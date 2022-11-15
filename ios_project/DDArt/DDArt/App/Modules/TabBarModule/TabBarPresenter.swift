//
//  TabBarPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class TabBarPresenter {
	weak var view: TabBarViewInput?
    weak var moduleOutput: TabBarModuleOutput?

	private let router: TabBarRouterInput
	private let interactor: TabBarInteractorInput
    private var tabBars: [TabBarItemModel] = []

    init(router: TabBarRouterInput, interactor: TabBarInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TabBarPresenter: TabBarModuleInput {
}

extension TabBarPresenter: TabBarViewOutput {
    func getViews() {
        interactor.getTabBarItemsInfo()
    }
    
    func getModel(at index: Int) -> TabBarItemModel {
        self.tabBars[index]
    }
    
}

extension TabBarPresenter: TabBarInteractorOutput {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItemModel]) {
        self.tabBars = tabBar
        let views = self.router.getViews()
        self.view?.receiveViews(with: views)
    }
    
}
