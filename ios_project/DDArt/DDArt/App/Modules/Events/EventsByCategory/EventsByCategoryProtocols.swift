//
//  EventsByCategoryProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

protocol EventsByCategoryModuleInput {
	var moduleOutput: EventsByCategoryModuleOutput? { get }
    var category: CategoryModel? {get set}
}

protocol EventsByCategoryModuleOutput: AnyObject {
}

protocol EventsByCategoryViewInput: AnyObject {
    func reloadData()
}

protocol EventsByCategoryViewOutput: AnyObject {
    func viewDidLoad()
    func clickOnEvent(with id: Int)
    func getCountEventCells() -> Int
    func getEventCell(with index: Int) -> EventModel
}

protocol EventsByCategoryInteractorInput: AnyObject {
    func loadEventsByCategory(category: CategoryModel)
}

protocol EventsByCategoryInteractorOutput: AnyObject {
    func receiveData(events: [EventModel])
}

protocol EventsByCategoryRouterInput: AnyObject {
    func eventSelected(event: EventModel)
}
