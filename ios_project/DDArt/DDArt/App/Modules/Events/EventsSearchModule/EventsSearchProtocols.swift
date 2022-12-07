//
//  EventsSearchProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol EventsSearchModuleInput {
	var moduleOutput: EventsSearchModuleOutput? { get }
}

protocol EventsSearchModuleOutput: AnyObject {
    var events: [EventModel] {get set}
}
protocol TableCategoryViewCellOutput: AnyObject {
    func clickOnEvent(with id: Int)
}

protocol EventsSearchViewInput: AnyObject {
    func reloadData()
}

protocol EventsSearchViewOutput: AnyObject {
    func viewDidload()
    func getCountEventCells() -> Int
    func clickOnEvent(with id: Int)
    func sortEvents(typeSort type: typeSort, by order: Ordered)
    func searchEventByName(with name: String)
    func getCountCategoryCells() -> Int
    func clickOnCategory(with id: Int)
}

protocol EventsSearchInteractorInput: AnyObject {
    func loadAllEvents() -> [EventModel]
    func loadAllCategories()
    func searchEventByName(with name: String)
}

protocol EventsSearchInteractorOutput: AnyObject {
    func recieveCategories(categories: [CategoryModel])
    func recieveEvents(events: [EventModel])
    
}

protocol EventsSearchRouterInput: AnyObject {
    func categorySelected(with view: EventsSearchViewInput?, and category: CategoryModel)
    func eventSelected(with view: EventsSearchViewInput?, and event: EventModel)
}

