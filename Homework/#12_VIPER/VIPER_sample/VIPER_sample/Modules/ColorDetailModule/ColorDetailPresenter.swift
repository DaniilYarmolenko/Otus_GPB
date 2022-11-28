//
//  ColorDetailPresenter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class ColorDetailPresenter {
	weak var view: ColorDetailViewInput?
    weak var moduleOutput: ColorDetailModuleOutput?
    var color: Color?
	private let router: ColorDetailRouterInput
	private let interactor: ColorDetailInteractorInput
    private var viewModel: ColorDetailViewModel?
    
    init(router: ColorDetailRouterInput, interactor: ColorDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ColorDetailPresenter: ColorDetailModuleInput {
    var colorType: Color? {
        get {
            return color
        }
        set {
            color = newValue
        }
    }
}

extension ColorDetailPresenter: ColorDetailViewOutput {
    func getCellIdentifier(at index: Int) -> String {
        viewModel?.array[index].cellIdentifier ?? ""
    }
    
    
    func viewDidLoad() {
        interactor.loadData(colorType: color ?? .red)
    }
    
    func getCellsCount() -> Int {
        return  viewModel?.array.count ?? 0
    }
    
    func getCell(at index: Int) -> ColorDetailModel {
        viewModel?.array[index] ?? ColorDetailModel(red: 0.0, green: 0.0, blue: 0.0)
    }
    
    func openFullScreen(index: Int) {
        self.router.openFullScreen(with: self.view, colorData: interactor
            .receiveData(index: index))
    }
    
}

extension ColorDetailPresenter: ColorDetailInteractorOutput {
    func receiveData(data: [ColorDetailModel]) {
        viewModel = ColorDetailViewModel(newColor: data)
        view?.reloadData()
    }
    
}
