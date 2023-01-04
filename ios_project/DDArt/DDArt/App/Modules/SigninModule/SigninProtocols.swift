//
//  SigninProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import Foundation

protocol SigninModuleInput {
	var moduleOutput: SigninModuleOutput? { get }
}

protocol SigninModuleOutput: AnyObject {
}

protocol SigninViewInput: AnyObject {
}

protocol SigninViewOutput: AnyObject {
    func loginUser(login: String, password: String) -> Bool
    func tapSignUp()
}

protocol SigninInteractorInput: AnyObject {
}

protocol SigninInteractorOutput: AnyObject {
}

protocol SigninRouterInput: AnyObject {
}
