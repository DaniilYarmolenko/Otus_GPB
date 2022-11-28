//
//  BuyColorProtocols.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//  
//

import Foundation

protocol BuyColorModuleInput {
	var moduleOutput: BuyColorModuleOutput? { get }
    var modelInput: ColorDetailModel? { get set }
}

protocol BuyColorModuleOutput: AnyObject {
}

protocol BuyColorViewInput: AnyObject {
    func updateButton(selected: Bool)
}

protocol BuyColorViewOutput: AnyObject {
    func viewDidLoad()
    func clickBuy(selected: Bool)
    func checkCart()
    func itemDidLoad()
}

protocol BuyColorInteractorInput: AnyObject {
    func addToCart(selected: Bool)
    func itemDidLoad(model: ColorDetailModel)
    func inCart(id: Int) -> Bool
}

protocol BuyColorInteractorOutput: AnyObject {
    func itemDidLoad(model: ColorDetailModel)
}

protocol BuyColorRouterInput: AnyObject {
}
protocol ServiceAddCartInput: AnyObject {
    func isContain(with id: Int) -> Bool
    func delete(with id: Int)
    func insert(with model: ColorDetailModel)
    func fetchAll() -> [Cart]
    func deleteAll()
}
protocol ServiceManagerModelInput: AnyObject {
    func loadItemById(with id: Int)
}

protocol ServiceManagerModelOutput: AnyObject {
    func didFail(with error: Error)
}

