//
//  CartPresenter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class CartPresenter {
	weak var view: CartViewInput?
    weak var moduleOutput: CartModuleOutput?
    var array = [ColorDetailModel]()
	private let router: CartRouterInput
	private let interactor: CartInteractorInput

    init(router: CartRouterInput, interactor: CartInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CartPresenter: CartModuleInput {
}

extension CartPresenter: CartViewOutput {
    func delete(id: Int) {
        interactor.deleteBy(with: id)
    }
    
    func deleteAll() {
        interactor.deleteAll()
    }
    
    func getCell(id: Int) -> ColorDetailModel? {
        array[id]
    }
    func getCellsCount() -> Int {
        array.count
    }
    func viewDidLoad() {
        interactor.getCartItems()
    }
    
    func goToCheckout() {
        router.goToCheckout(from: view, data: array)
        deleteAll()
    }
    
    func checkEmpty() -> Bool {
        array.isEmpty
    }
    
}

extension CartPresenter: CartInteractorOutput {
    func getCartItems(colors: [ColorDetailModel]) {
        array = colors
        view?.loadData()
    }
    
}
