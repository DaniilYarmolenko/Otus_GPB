//
//  EventsSearchProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

protocol EventsSearchModuleInput {
	var moduleOutput: EventsSearchModuleOutput? { get }
}

protocol EventsSearchModuleOutput: AnyObject {
    var events: [EventModel] {get set}
}


protocol EventsSearchViewInput: AnyObject {
    func reloadCategory()
    func reloadTableData()
}

protocol EventsSearchViewOutput: AnyObject {
    func viewDidload()
    func getCountEventCells() -> Int
    func clickOnEvent(with id: Int)
    func sortEvents(typeSort type: typeSort, by order: Ordered)
    func searchEventByName(with name: String)
    func updateEvents()
    func getCountCategoryCells() -> Int
    func clickOnCategory(with id: Int)
    func getEventCell(with index: Int) -> EventModel
    func getCategoryCell(with index: Int) -> CategoryModel
}

protocol EventsSearchInteractorInput: AnyObject {
    func loadAllEvents()
    func loadAllCategories()
    func searchEventByName(with name: String)
}

protocol EventsSearchInteractorOutput: AnyObject {
    func recieveCategories(categories: [CategoryModel])
    func recieveEvents(events: [EventModel])
    func recieveEventsSearch(events: [EventModel])
    
}

protocol EventsSearchRouterInput: AnyObject {
    func categorySelected(category: CategoryModel)
    func eventSelected(event: EventModel)
}

