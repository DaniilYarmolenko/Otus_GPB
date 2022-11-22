//
//  CartInteractor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class CartInteractor {
	weak var output: CartInteractorOutput?
}

extension CartInteractor: CartInteractorInput {
    func deleteAll() {
        ServiceAddCart.shared.deleteAll()
        var count = UserDefaults.standard.integer(forKey: "cart_count")
        count = 0
        UserDefaults.standard.set(count, forKey: "cart_count")
        NotificationCenter.default.post(name: NSNotification.Name("cart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("delete_cart"), object: nil)
        getCartItems()
    }
    
    func deleteBy(with id: Int) {
        ServiceAddCart.shared.delete(with: id)
        var count = UserDefaults.standard.integer(forKey: "cart_count")
        count = ServiceAddCart.shared.fetchAll().count
        UserDefaults.standard.set(count, forKey: "cart_count")
        NotificationCenter.default.post(name: NSNotification.Name("cart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("delete_cart"), object: nil)
        getCartItems()
    }
    
    func getCartItems() {
        let coreDataCart = ServiceAddCart.shared.fetchAll()
        let models = coreDataCart.map { cart in
            let model = ColorDetailModel(red: CGFloat(cart.red), green: CGFloat(cart.green), blue: CGFloat(cart.blue))
            return model
        }
        output?.getCartItems(colors: models)
    }
    
}
