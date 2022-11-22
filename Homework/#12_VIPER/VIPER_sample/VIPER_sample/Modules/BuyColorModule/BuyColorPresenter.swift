//
//  BuyColorPresenter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//  
//

import Foundation
import UIKit

final class BuyColorPresenter {
	weak var view: BuyColorViewInput?
    weak var moduleOutput: BuyColorModuleOutput?
    
    var model: ColorDetailModel?
	private let router: BuyColorRouterInput
	private let interactor: BuyColorInteractorInput
    init(router: BuyColorRouterInput, interactor: BuyColorInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension BuyColorPresenter: BuyColorModuleInput {
    weak var modelInput: ColorDetailModel? {
        get {
            return model
        }
        set {
            model = newValue
        }
    }
}

extension BuyColorPresenter: BuyColorViewOutput {
    
    func itemDidLoad() {
        interactor.itemDidLoad(model: model ?? ColorDetailModel(red: 0.0, green: 0.0, blue: 0.0))
    }
    func clickBuy(selected: Bool) {
        modelInput?.inCart = selected
        interactor.addToCart(selected: selected)
    }
    func checkCart() {
        let status = interactor.inCart(id: modelInput?.id ?? 0)
        view?.updateButton(selected: status)
    }
    
    func viewDidLoad() {
        checkCart()
    }
    
}

extension BuyColorPresenter: BuyColorInteractorOutput {
    func itemDidLoad(model: ColorDetailModel) {
        self.modelInput = model
    }
    
    
}
