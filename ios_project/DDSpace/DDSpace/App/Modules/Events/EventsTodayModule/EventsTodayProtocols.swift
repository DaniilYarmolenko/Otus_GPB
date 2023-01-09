//
//  EventsTodayProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

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
    func loadData()
    func getCountCell() -> Int
    func clickOnEvent(with id: Int)
    func clickOnRegisterButton(with id: UUID?)
    func getCell(with index: Int) -> EventModel
}

protocol EventsTodayInteractorInput: AnyObject {
    func loadTodayEvents()
}

protocol EventsTodayInteractorOutput: AnyObject {
    func receiveData(events: [EventModel])
    func didFail(message: String)
}

protocol EventsTodayRouterInput: AnyObject {
    func eventSelected(event: EventModel)
    func showAlertAuth(with view: EventsTodayViewInput?)
    func showOpsAlert(with view: EventsTodayViewInput?)
}
