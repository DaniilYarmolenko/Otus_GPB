//
//  DDPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class DDPresenter {
	weak var view: DDViewInput?
    weak var moduleOutput: DDModuleOutput?

	private let router: DDRouterInput
	private let interactor: DDInteractorInput

    init(router: DDRouterInput, interactor: DDInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DDPresenter: DDModuleInput {
}

extension DDPresenter: DDViewOutput {
}

extension DDPresenter: DDInteractorOutput {
}
