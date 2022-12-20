//
//  MenuPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import Foundation

final class MenuPresenter {
	weak var view: MenuViewInput?
    weak var moduleOutput: MenuModuleOutput?

	private let router: MenuRouterInput
	private let interactor: MenuInteractorInput

    init(router: MenuRouterInput, interactor: MenuInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MenuPresenter: MenuModuleInput {
}

extension MenuPresenter: MenuViewOutput {
}

extension MenuPresenter: MenuInteractorOutput {
}
