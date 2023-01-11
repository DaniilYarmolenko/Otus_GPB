//
//  DDProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol DDModuleInput {
    var moduleOutput: DDModuleOutput? { get }
}

protocol DDModuleOutput: AnyObject {
}

protocol DDViewInput: AnyObject {
    func reloadData()
}

protocol DDViewOutput: AnyObject {
    func viewDidLoad()
    func tapOnCategory(with id: Int)
    func tapOnNews(with id: Int)
    func tapOnMap()
    func tapOnPhone()
    func tapOnEmail()
    func getCellHeight(at index: Int) -> Float
    func getCell(at index: Int) -> CellIdentifiable?
    func getCellIdentifier(at index: Int) -> String
    func getCountCells() -> Int
    var  sectionDelegate: TableViewCellOutput? { get set }
    func goToAllNews()
    func goToMenu()
    func tapOnVk()
    func tapOnTelegram()
    func tapOnInstagram()
}

protocol DDInteractorInput: AnyObject {
    func loadData()
    func receiveId(with index: Int) -> Int
    func receiveCompilationTitle(with index: Int) -> String
}

protocol DDInteractorOutput: AnyObject {
    func receiveData(news: [NewsModel], categoriesFoods: [FoodCategory], info: [InfoModel])
    func didFail(message: String)
}

protocol DDRouterInput: AnyObject {
    func categoryFoodSelected(with view: DDViewInput?, and id: Int, foodCategories: [FoodCategory])
    func newsSelected(with view: DDViewInput?, news: NewsModel)
    func goToMenu(with view: DDViewInput?, foodCategory: [FoodCategory])
    func goToAllNews(with view: DDViewInput?, news: [NewsModel])
    func presentMap(with view: DDViewInput?)
    func tapToUnworkButton(with view: DDViewInput?, message: String)
}

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Float { get }
}
protocol SectionRowsRepresentable {
    var rows: [CellIdentifiable] { get set }
}

protocol TableViewCellOutput: AnyObject {
    func tapMoreNews()
    func tapMoreFood()
    func tapOnNews(with id: Int)
    func tapOnCategory(with id: Int)
    func tapOnMap()
    func tapOnPhone()
    func tapOnEmail()
    func tapOnVk()
    func tapOnTelegram()
    func tapOnInstagram()
    
}
