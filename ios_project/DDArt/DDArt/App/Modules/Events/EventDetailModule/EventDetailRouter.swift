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
    func showAlertAuth(with view: EventDetailViewInput?) {
        let alert = UIAlertController(title: "В не залогинились", message: "Вы точно хотите все удалить ?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Log in", style: .default) { _ in
            guard let view = view as? UIViewController else { return }
            let authVC = AuthContainer.assemble(with: AuthContext()) // MARK: Add Eventcontext
            view.navigationController?.present(authVC.viewController, animated: true)
        }
        let actionFailure = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        guard let vc = view as? UIViewController else {
            print("ERROR")
            return}
        vc.navigationController?.present(alert, animated: true, completion: nil)
    }
}
