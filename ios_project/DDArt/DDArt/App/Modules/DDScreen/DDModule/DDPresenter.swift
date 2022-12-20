//
//  DDPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class DDPresenter {
	weak var view: DDViewInput?
    weak var moduleOutput: DDModuleOutput?

	private let router: DDRouterInput
	private let interactor: DDInteractorInput
    private var ddSectionViewModel: DDSectionViewModel?

    init(router: DDRouterInput, interactor: DDInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DDPresenter: DDModuleInput {
}

extension DDPresenter: DDViewOutput {
    func viewDidLoad() {
        ddSectionViewModel = DDSectionViewModel()
        loadData()
    }
    func loadData() {
        ddSectionViewModel = DDSectionViewModel()
        interactor.loadData()
    }
    func tapOnCategory(with id: Int) {
        guard let category = ddSectionViewModel?.rows[3] as?  FoodCategoriesCollectionViewModel else { return }
//        router.authorSelected(with: view, and: author.array[id].id)
    }
    
    func tapOnNews(with id: Int) {
        router.newsSelected(with: view, and: id)
    }
    
    func tapOnMap() {
        
        router.presentMap(with: view)
    }
    
    func tapOnPhone() {
        
    }
    
    func tapOnEmail() {
    }
    
    func getCellHeight(at index: Int) -> Float {
        guard let ddSectionViewModel = ddSectionViewModel else { return -1 }
        return ddSectionViewModel.rows[index].cellHeight
    }
    
    func getCell(at index: Int) -> CellIdentifiable? {
        guard let ddSectionViewModel = ddSectionViewModel else { return nil }
        return ddSectionViewModel.rows[index]
    }
    
    func getCellIdentifier(at index: Int) -> String {
        guard let ddSectionViewModel = ddSectionViewModel else { return "" }
        return ddSectionViewModel.rows[index].cellIdentifier
    }
    
    func getCountCells() -> Int {
        guard let ddSectionViewModel = ddSectionViewModel else { return 0 }
        
        return ddSectionViewModel.rows.count
    }
    
    var sectionDelegate: TableViewCellOutput? {
        get {
            guard let ddSectionViewModel = ddSectionViewModel else { return nil }
            return ddSectionViewModel.actions
        }
        set {
            ddSectionViewModel?.actions = newValue
        }
    }
    
    func goToAllNews() {
        router.goToAllNews(with: view)
    }
    
    func goToMenu() {
        router.goToMenu(with: view)
    }
    
    func tapOnVk() {
//
    }
    
    func tapOnTelegram() {
//
    }
    
    func tapOnInstagram() {
//
    }
    
}

extension DDPresenter: DDInteractorOutput {
    func didFail(message: String) {
        print("LOGIC \(message)")
    }
    
    func receiveData(news: [NewsModel], categoriesFoods: [FoodCategory], info: [InfoModel]) {
        ddSectionViewModel?.fillData(news: news, categoriesFood: categoriesFoods, info: info, output: self)
        view?.reloadData()
    }
    
    
    
}
