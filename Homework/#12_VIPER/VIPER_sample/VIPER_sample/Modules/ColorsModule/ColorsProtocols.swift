//
//  ColorsProtocols.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

protocol ColorsModuleInput {
	var moduleOutput: ColorsModuleOutput? { get }
}

protocol ColorsModuleOutput: AnyObject {
}

protocol ColorsViewInput: AnyObject {
    func reloadData()
}

protocol ColorsViewOutput: AnyObject {
    func viewDidLoad()
    func getCell(at index: Int) -> ColorModel
    func getCellsCount() -> Int
    func getCellIdentifier(at index: Int) -> String
    func itemSelected(index: Int)
}

protocol ColorsInteractorInput: AnyObject {
    func loadData()
    func receiveData(index: Int) -> ColorModel
}

protocol ColorsInteractorOutput: AnyObject {
    func receiveData(data: [ColorModel])
}

protocol ColorsRouterInput: AnyObject {
    func itemSelected(with view: ColorsViewInput?, and model: ColorModel)
}

protocol ColorsMockInput: AnyObject {
    func requestToMockService()
}

protocol ColorsMockOutput: AnyObject {
    func receiveFromMock<T>(data: [T])
}
