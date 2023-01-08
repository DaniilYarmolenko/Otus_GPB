//
//  SignUpRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//  
//

import UIKit

final class SignUpRouter {
}

extension SignUpRouter: SignUpRouterInput {
    func errorAlert(with view: SignUpViewInput?, message: String) {
        guard let view = view as? UIViewController else {return}
        ErrorPresenter.showError(message: message, on: view)
    }
    
    func successSignUp(with view: SignUpViewInput?) {
        let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = tabBarContainer.viewController
        }
    }
    
    func dismiss(with view: SignUpViewInput?) {
        guard let view = view as? UIViewController else {return}
        view.dismiss(animated: true)
    }
    
    
}
