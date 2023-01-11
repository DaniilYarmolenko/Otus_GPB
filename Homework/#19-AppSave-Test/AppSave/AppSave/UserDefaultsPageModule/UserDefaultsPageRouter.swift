//
//  UserDefaultsPageRouter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class UserDefaultsPageRouter {
}

extension UserDefaultsPageRouter: UserDefaultsPageRouterInput {
    func goToDeleteAlert(from vc: UserDefaultsPageViewInput?) {
        let alert = UIAlertController(title: "Удаление объектов", message: "Вы точно хотите все удалить ?", preferredStyle: .alert)
        let actionSuccsess = UIAlertAction(title: "Да", style: .destructive) { _ in
            NotificationCenter.default.post(name: NSNotification.Name("DeleteAllCacheDataItems"), object: nil)
        }
        let actionFailure = UIAlertAction(title: "Нет", style: .default)
        alert.addAction(actionFailure)
        alert.addAction(actionSuccsess)
        guard let view = vc as? UIViewController else {
            print("ERROR")
            return}
        view.navigationController?.present(alert, animated: true, completion: nil)
    }
    
}
