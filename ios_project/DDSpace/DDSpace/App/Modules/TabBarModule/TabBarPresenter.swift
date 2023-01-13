//
//  TabBarPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

final class TabBarPresenter {
	weak var view: TabBarViewInput?
    weak var moduleOutput: TabBarModuleOutput?

	private let router: TabBarRouterInput
	private let interactor: TabBarInteractorInput
    private var tabBars: [TabBarItemModel] = []
    var views = [UIViewController]()
    init(router: TabBarRouterInput, interactor: TabBarInteractorInput) {
        self.router = router
        self.interactor = interactor
        self.views = [EventsContainer.assemble(with: EventsContext()).viewController,
                      DDContainer.assemble(with: DDContext()).viewController,
                      ExtraScreenContainer.assemble(with: ExtraScreenContext()).viewController]
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
        self.view?.receiveViews(with: views, tabBar: tabBar)
    }
    
}
