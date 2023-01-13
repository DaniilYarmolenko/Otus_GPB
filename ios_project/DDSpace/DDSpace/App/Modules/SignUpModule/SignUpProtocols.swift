//
//  SignUpProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//  
//

import Foundation

protocol SignUpModuleInput {
    var moduleOutput: SignUpModuleOutput? { get }
}

protocol SignUpModuleOutput: AnyObject {
}

protocol SignUpViewInput: AnyObject {
}

protocol SignUpViewOutput: AnyObject {
    func noConfirm()
    func signUp(firstName: String, secondName: String, userName: String, email: String, password: String)
    func dismiss()
}

protocol SignUpInteractorInput: AnyObject {
    func signUpUser(firstName: String, secondName: String, userName: String, email: String, password: String)
}

protocol SignUpInteractorOutput: AnyObject {
    func successSignUp()
    func errorSignUp()
}

protocol SignUpRouterInput: AnyObject {
    func dismiss(with view: SignUpViewInput?)
    func errorAlert(with view: SignUpViewInput?, message: String)
    func successSignUp(with view: SignUpViewInput?)
}
