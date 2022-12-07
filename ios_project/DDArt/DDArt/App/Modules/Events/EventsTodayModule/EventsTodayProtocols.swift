//
//  EventsTodayProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol EventsTodayModuleInput {
	var moduleOutput: EventsTodayModuleOutput? { get }
}

protocol EventsTodayModuleOutput: AnyObject {
    var event: EventModel? {get set}
}

protocol EventsTodayViewInput: AnyObject {
    func reloadData()
}
protocol TableEventViewCellOutput: AnyObject {
    func clickOnEvent(with id: Int)
}

protocol EventsTodayViewOutput: AnyObject {
    func viewDidLoad()
    func getCountCell() -> Int
    func clickOnEvent(with id: Int)
}

protocol EventsTodayInteractorInput: AnyObject {
    func loadTodayEvents()
}

protocol EventsTodayInteractorOutput: AnyObject {
    func receiveData(events: [EventModel])
}

protocol EventsTodayRouterInput: AnyObject {
    func eventSelected(with view: EventsTodayViewInput?, and event: EventModel)
}
