//
//  ExtraScreenRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class ExtraScreenRouter {
}

extension ExtraScreenRouter: ExtraScreenRouterInput {
    func touchLogoutButton(view: ExtraScreenViewInput?) {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы хотит выйти ?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Да", style: .destructive) { _ in
            Auth().token = nil
            let signIn = SigninContainer.assemble(with: SigninContext()) // MARK: Add Eventcontext
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = signIn.viewController
            }
        }
        let actionFailure = UIAlertAction(title: "Нет", style: .default)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        guard let vc = view as? UIViewController, let navigationController = vc.navigationController else {
            return}
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func touchLoginButton(view: ExtraScreenViewInput?) {
        let signIn = SigninContainer.assemble(with: SigninContext()) // MARK: Add Eventcontext
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = signIn.viewController
        }
    }
    
}
