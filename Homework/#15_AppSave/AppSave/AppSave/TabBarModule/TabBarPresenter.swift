//
//  TabBarPresenter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class TabBarPresenter {
	weak var view: TabBarViewInput?
    weak var moduleOutput: TabBarModuleOutput?

	private let router: TabBarRouterInput
	private let interactor: TabBarInteractorInput
    private var tabBars = [TabBarItem]()

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
    
    func getModel(at index: Int) -> TabBarItem {
        self.tabBars[index]
    }
}

extension TabBarPresenter: TabBarInteractorOutput {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItem]) {
        self.tabBars = tabBar
        let views = self.router.getViews()
        self.view?.receiveViews(with: views)
    }
}
