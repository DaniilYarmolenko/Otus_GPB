//
//  AuthPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

final class AuthPresenter {
	weak var view: AuthViewInput?
    weak var moduleOutput: AuthModuleOutput?

	private let router: AuthRouterInput
	private let interactor: AuthInteractorInput

    init(router: AuthRouterInput, interactor: AuthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthModuleInput {
}

extension AuthPresenter: AuthViewOutput {
}

extension AuthPresenter: AuthInteractorOutput {
}
