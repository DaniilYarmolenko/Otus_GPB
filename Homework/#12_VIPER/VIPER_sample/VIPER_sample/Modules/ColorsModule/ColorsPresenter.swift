//
//  ColorsPresenter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class ColorsPresenter {
	weak var view: ColorsViewInput?
    weak var moduleOutput: ColorsModuleOutput?

	private let router: ColorsRouterInput
	private let interactor: ColorsInteractorInput
    private var viewModel: ColorsViewModel?

    init(router: ColorsRouterInput, interactor: ColorsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ColorsPresenter: ColorsModuleInput {
}

extension ColorsPresenter: ColorsViewOutput {
    func viewDidLoad() {
        interactor.loadData()
    }
    
    func getCell(at index: Int) -> ColorModel {
        viewModel?.array[index] ?? ColorModel(red: 0.0, green: 0.0, blue: 0.0, colorType: .red)
    }
    
    func getCellsCount() -> Int {
        viewModel?.array.count ?? 0
    }
    
    func getCellIdentifier(at index: Int) -> String {
        viewModel?.array[index].cellIdentifier ?? ""
    }
    
    func itemSelected(index: Int) {
        self.router.itemSelected(with: self.view, and: interactor.receiveData(index: index))
    }
    
}

extension ColorsPresenter: ColorsInteractorOutput {
    func receiveData(data: [ColorModel]) {
        viewModel = ColorsViewModel(newColor: data)
        view?.reloadData()
    }
    
}
