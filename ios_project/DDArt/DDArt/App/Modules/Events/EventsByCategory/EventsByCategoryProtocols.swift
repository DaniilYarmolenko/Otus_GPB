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
    func getCountCell() -> Int
    func clickOnEvent(with id: Int)
}

protocol EventsByCategoryInteractorInput: AnyObject {
    func loadEventsByCategory(category: CategoryModel)
}

protocol EventsByCategoryInteractorOutput: AnyObject {
    func receiveData(events: [EventModel])
}

protocol EventsByCategoryRouterInput: AnyObject {
    func eventSelected(with view: EventsByCategoryViewInput?, and event: EventModel)
}
