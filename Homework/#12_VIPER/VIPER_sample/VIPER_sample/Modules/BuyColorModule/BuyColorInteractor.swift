//
//  BuyColorInteractor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//  
//

import Foundation

final class BuyColorInteractor {
	weak var output: BuyColorInteractorOutput?
    private var isSelected: Bool = false
    private var serviceAddCart: ServiceAddCartInput?
    private var colorDetailModel: ColorDetailModel?
    init() {
        serviceAddCart = ServiceAddCart.shared
    }
}

extension BuyColorInteractor: BuyColorInteractorInput {
    func addToCart(selected: Bool) {
        var count = UserDefaults.standard.integer(forKey: "cart_count")
        guard let colorDetailModel = colorDetailModel else { return }
        if isSelected && !selected {
            serviceAddCart?.delete(with: colorDetailModel.id)
        }
        if isSelected && selected {
            serviceAddCart?.delete(with: colorDetailModel.id)
            serviceAddCart?.insert(with: colorDetailModel)
        }
        
        if !isSelected && selected {
            serviceAddCart?.insert(with: colorDetailModel)
        }
        
        isSelected = selected
        count = serviceAddCart?.fetchAll().count ?? 0
        UserDefaults.standard.set(count, forKey: "cart_count")
        NotificationCenter.default.post(name: NSNotification.Name("cart"), object: nil)
    }
    
    func inCart(id: Int) -> Bool {
        guard let serviceAddCart = serviceAddCart else { return false }
        guard let colorDetailModel = colorDetailModel else {
            return serviceAddCart.isContain(with: id)
        }
        let res = serviceAddCart.isContain(with: colorDetailModel.id)
        isSelected = res
        colorDetailModel.inCart = res
        return res
    }
    func itemDidLoad(model: ColorDetailModel) {
        self.colorDetailModel = model
        output?.itemDidLoad(model: model)
    }
}

extension BuyColorInteractor: ServiceManagerModelOutput {
    
    func didFail(with error: Error) {
        print(error.localizedDescription)
    }
    
    
}
