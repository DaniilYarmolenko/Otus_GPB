//
//  EventDetailRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import UIKit

final class EventDetailRouter {
}

extension EventDetailRouter: EventDetailRouterInput {
    func showOpsAlert(with view: EventDetailViewInput?) {
        let alert = UIAlertController(title: "Данный функционал не работает(", message: "Простите пожалуйста, я доделаю регистрацию с токенами((", preferredStyle: .alert)
        let actionFailure = UIAlertAction(title: "Простить", style: .default)
        alert.addAction(actionFailure)
        guard let vc = view as? UIViewController, let navigationController = vc.navigationController else {
            return}
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func showAlertAuth(with view: EventDetailViewInput?) {
        let alert = UIAlertController(title: "В не залогинились", message: "Вы точно хотите все удалить ?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Log in", style: .default) { _ in
            guard let view = view as? UIViewController else { return }
            let signIn = SigninContainer.assemble(with: SigninContext()) // MARK: Add Eventcontext
            view.navigationController?.present(signIn.viewController, animated: true)
        }
        let actionFailure = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        guard let vc = view as? UIViewController, let navigationController = vc.navigationController else {
            return}
        navigationController.present(alert, animated: true, completion: nil)
    }
}
