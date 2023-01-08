//
//  EventsTodayRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayRouter {
    var navigationController: UINavigationController?
}

extension EventsTodayRouter: EventsTodayRouterInput {
    func eventSelected(event: EventModel) {
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        self.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
    func showOpsAlert(with view: EventsTodayViewInput?) {
        print("LOGIC TAP 3")
        let alert = UIAlertController(title: "Данный функционал не работает(", message: "Простите пожалуйста, я доделаю регистрацию с токенами((", preferredStyle: .alert)
        let actionFailure = UIAlertAction(title: "Простить", style: .default)
        alert.addAction(actionFailure)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertAuth(with view: EventsTodayViewInput?) {
        print("LOGIC TAP 4")
        let alert = UIAlertController(title: "В не залогинились", message: "Вы точно хотите все удалить ?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Log in", style: .default) { _ in
            let signIn = SigninContainer.assemble(with: SigninContext()) // MARK: Add Eventcontext
            self.navigationController?.present(signIn.viewController, animated: true)
        }
        let actionFailure = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
