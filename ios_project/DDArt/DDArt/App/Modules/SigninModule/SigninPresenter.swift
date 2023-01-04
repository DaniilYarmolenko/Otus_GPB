//
//  SigninPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import Foundation

final class SigninPresenter {
	weak var view: SigninViewInput?
    weak var moduleOutput: SigninModuleOutput?

	private let router: SigninRouterInput
	private let interactor: SigninInteractorInput

    init(router: SigninRouterInput, interactor: SigninInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SigninPresenter: SigninModuleInput {
}

extension SigninPresenter: SigninViewOutput {
    func loginUser(login: String, password: String) -> Bool {
        true
    }
    
    func tapSignUp() {
        
    }
    
}

extension SigninPresenter: SigninInteractorOutput {
}
