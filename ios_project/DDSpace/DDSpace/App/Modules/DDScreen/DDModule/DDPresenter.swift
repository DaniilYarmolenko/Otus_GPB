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
        interactor.loadData()
    }
    func tapOnCategory(with id: Int) {
        guard let foodCategory = ddSectionViewModel?.rows[3] as?  FoodCategoriesCollectionViewModel else { return }
        router.categoryFoodSelected(with: view, and: id, foodCategories: foodCategory.array)
    }
    
    func tapOnNews(with id: Int) {
        guard let news = ddSectionViewModel?.rows[1] as?  NewsCollectionViewModel else { return }
        router.newsSelected(with: self.view, news: news.array[id])
    }
    
    func tapOnMap() {
        router.tapToUnworkButton(with: view, message: "Причина: карта итак зумится, зачем тебе фулскрин ?)")
    }
    
    func tapOnPhone() {
        router.tapToUnworkButton(with: view, message: "Причина: мы забыли оплатить телефон:(")
    }
    
    func tapOnEmail() {
        router.tapToUnworkButton(with: view, message: "Робот Федор еще не отошел от новогодних праздников")
    }
    
    func getCellHeight(at index: Int) -> Float {
        guard let ddSectionViewModel = ddSectionViewModel else { return -1 }
        if ddSectionViewModel.rows.count >= index {
            return ddSectionViewModel.rows[index].cellHeight
        }
        return -1
    }
    
    func getCell(at index: Int) -> CellIdentifiable? {
        guard let ddSectionViewModel = ddSectionViewModel else { return nil }
        return ddSectionViewModel.rows[index]
    }
    
    func getCellIdentifier(at index: Int) -> String {
        guard let ddSectionViewModel = ddSectionViewModel else { return "" }
        if index == 5 {
            return InfoViewCell.cellIdentifier
        } else {
            return ddSectionViewModel.rows[index].cellIdentifier
        }
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
        guard let news = ddSectionViewModel?.rows[1] as?  NewsCollectionViewModel else { return }
        router.goToAllNews(with: self.view, news: news.array)
    }
    
    func goToMenu() {
        guard let foodCategory = ddSectionViewModel?.rows[3] as?  FoodCategoriesCollectionViewModel else { return }
        router.goToMenu(with: view, foodCategory: foodCategory.array)
    }
    
    func tapOnVk() {
        router.tapToUnworkButton(with: view, message: "Причина зачем VK, если тут есть вся иннформация ?)")
    }
    
    func tapOnTelegram() {
        router.tapToUnworkButton(with: view, message: "Причина: не оплатили премимум, а без него не оч")
    }
    
    func tapOnInstagram() {
        router.tapToUnworkButton(with: view, message: "Причина: заблокировано роскомнадзором")
    }
    
}

extension DDPresenter: DDInteractorOutput {
    func didFail(message: String) {
    }
    
    func receiveData(news: [NewsModel], categoriesFoods: [FoodCategory], info: [InfoModel]) {
        ddSectionViewModel?.fillData(news: news, categoriesFood: categoriesFoods, info: info, output: self)
        view?.reloadData()
    }
    
    
    
}
