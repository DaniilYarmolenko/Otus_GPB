//
//  ColorDetailProtocols.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation
import UIKit

protocol ColorDetailModuleInput {
	var moduleOutput: ColorDetailModuleOutput? { get }
    var colorType: Color? { get set }

}

protocol ColorDetailModuleOutput: AnyObject {
}

protocol ColorDetailViewInput: AnyObject {
    func reloadData()
}

protocol ColorDetailViewOutput: AnyObject {
    func viewDidLoad()
    func getCellsCount() -> Int
    func getCell(at index: Int) -> ColorDetailModel
    func getCellIdentifier(at index: Int) -> String
    func openFullScreen(index: Int)
    
}

protocol ColorDetailInteractorInput: AnyObject {
    func loadData(colorType: Color)
    func receiveData(index: Int) -> ColorDetailModel
}

protocol ColorDetailInteractorOutput: AnyObject {
    func receiveData(data: [ColorDetailModel])
}

protocol ColorDetailRouterInput: AnyObject {
    func openFullScreen(with view: ColorDetailViewInput?, colorData: ColorDetailModel)
}
protocol ModelRepresentable {
    var model: BaseCellModel? { get set }
}
