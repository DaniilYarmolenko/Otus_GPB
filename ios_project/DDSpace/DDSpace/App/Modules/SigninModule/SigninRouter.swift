//
//  SigninRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import UIKit

final class SigninRouter {
}

extension SigninRouter: SigninRouterInput {
    func successLogin() {
        DispatchQueue.main.async {
            let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = nil
            appDelegate?.window?.rootViewController = tabBarContainer.viewController
        }
    }
    
    func goAsGuess() {
        let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = nil
            appDelegate?.window?.rootViewController = tabBarContainer.viewController
        }
    }
    
    
    func signUp(with view: SigninViewInput?) {
        guard let view = view as? UIViewController else {return}
        let signUpContainer = SignUpContainer.assemble(with: SignUpContext())
        let controller = signUpContainer.viewController
        controller.modalPresentationStyle = .fullScreen
        view.present(controller, animated: true)
    }
    
}
