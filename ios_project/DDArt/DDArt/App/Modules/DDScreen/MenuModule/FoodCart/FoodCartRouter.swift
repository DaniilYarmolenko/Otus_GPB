//
//  FoodCartRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodCartRouter {
}

extension FoodCartRouter: FoodCartRouterInput {
    
    func showAlertAuth(with view: FoodCartViewInput?) {
        let alert = UIAlertController(title: "Вы не можте заказать, залогиньтесь", message: "Хотите залогиниться?", preferredStyle: .alert)
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
    
    func showOpsAlert(with view: FoodCartViewInput?) {
        let alert = UIAlertController(title: "Мне очень жаль:(", message: "Из-за санкций нее получится закказать онлайн", preferredStyle: .alert)
        
        let actionFailure = UIAlertAction(title: "Простить", style: .default)
        alert.addAction(actionFailure)
        guard let vc = view as? UIViewController, let navigationController = vc.navigationController else {
            return}
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func goToDeleteAlert(from vc: FoodCartViewInput?, output: FoodCartViewOutput) {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы хотите удалить все блюда из заказа?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Dа", style: .destructive) { _ in
            output.deleteAllItems()
        }
        let actionFailure = UIAlertAction(title: "No", style: .default)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        guard let vc = vc as? UIViewController, let navigationController = vc.navigationController else {
            return}
        navigationController.present(alert, animated: true, completion: nil)
    }
    
}
