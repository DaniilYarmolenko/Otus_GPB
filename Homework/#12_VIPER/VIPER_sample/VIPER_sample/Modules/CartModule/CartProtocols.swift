//
//  CartProtocols.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

protocol CartModuleInput {
	var moduleOutput: CartModuleOutput? { get }
}

protocol CartModuleOutput: AnyObject {
}

protocol CartViewInput: AnyObject {
    func  loadData()
}
protocol CartViewCellOutput: AnyObject {
    func deleteRent(with id: Int)
    func deleteBuy(with id: Int)
}

protocol CartViewOutput: AnyObject {
    func viewDidLoad()
    func goToCheckout()
    func checkEmpty() -> Bool
    func getCell(id: Int) -> ColorDetailModel?
    func delete(id: Int)
    func getCellsCount() -> Int
    func deleteAll()
}

protocol CartInteractorInput: AnyObject {
    func getCartItems()
    func deleteBy(with id: Int)
    func deleteAll()
}

protocol CartInteractorOutput: AnyObject {
    func getCartItems(colors: [ColorDetailModel])
}

protocol CartRouterInput: AnyObject {
    func goToCheckout(from vc: CartViewInput?, data: [ColorDetailModel])
}
protocol ServiceCartModelInput: AnyObject {
    func loadItemsByIds(with ids: [Int])
}

protocol ServiceCartModelOutput: AnyObject {
    func itemDidLoad(colors: [ColorDetailModel])
    func didFail(with error: Error)
}
