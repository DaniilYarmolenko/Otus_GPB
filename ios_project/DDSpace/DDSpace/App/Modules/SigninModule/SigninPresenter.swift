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
    func tapOnSignUp() {
        router.signUp(with: view)
    }
    
    func tapOnGuess() {
        router.goAsGuess()
    }
    
    func loginUser(login: String, password: String) {
        Auth().login(username: login, password: password) { result in
            switch result {
            case .success:
                self.router.successLogin()
            case .failure:
                self.view?.errorLogin()
            }
        }
    }
    
}

extension SigninPresenter: SigninInteractorOutput {
}
