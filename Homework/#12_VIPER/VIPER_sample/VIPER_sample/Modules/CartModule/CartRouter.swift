//
//  CartRouter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class CartRouter {
}

extension CartRouter: CartRouterInput {
    func goToCheckout(from vc: CartViewInput?, data: [ColorDetailModel]) {
        let alert = UIAlertController(title: "Поздравляю!", message: "Вы успеешно заказали цвета", preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        guard let view = vc as? UIViewController else {
            return}
        view.navigationController?.present(alert, animated: true, completion: nil)
    }
}
