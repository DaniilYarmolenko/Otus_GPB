//
//  EventsFutureProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol EventsFutureModuleInput {
    var moduleOutput: EventsFutureModuleOutput? { get }
}

protocol EventsFutureModuleOutput: AnyObject {
    var event: EventModel? {get set}
}

protocol EventsFutureViewInput: AnyObject {
    func reloadData()
}

protocol EventsFutureViewOutput: AnyObject {
    func loadData()
    func getCountCell() -> Int
    func getCell(index: Int) -> EventModel
    func clickOnEvent(with id: Int)
}

protocol EventsFutureInteractorInput: AnyObject {
    func loadFutureEvents()
}

protocol EventsFutureInteractorOutput: AnyObject {
    func receiveData(events: [EventModel])
}

protocol EventsFutureRouterInput: AnyObject {
    func eventSelected(event: EventModel)
}
