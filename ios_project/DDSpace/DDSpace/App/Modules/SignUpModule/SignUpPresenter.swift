//
//  SignUpPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//  
//

import Foundation

final class SignUpPresenter {
	weak var view: SignUpViewInput?
    weak var moduleOutput: SignUpModuleOutput?

	private let router: SignUpRouterInput
	private let interactor: SignUpInteractorInput

    init(router: SignUpRouterInput, interactor: SignUpInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresenter: SignUpModuleInput {
}

extension SignUpPresenter: SignUpViewOutput {
    func dismiss() {
        router.dismiss(with: view)
    }
    
    func noConfirm() {
        router.errorAlert(with: view, message: "password no confirm")
    }
    
    func signUp(firstName: String, secondName: String, userName: String, email: String, password: String) {
        interactor.signUpUser(firstName: firstName, secondName: secondName, userName: userName, email: email, password: password)
    }
    
}

extension SignUpPresenter: SignUpInteractorOutput {
    func errorSignUp() {
        router.errorAlert(with: view, message: "Error registration")
    }
    
    func successSignUp() {
        router.successSignUp(with: view)
    }
    
}
