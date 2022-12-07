//
//  EventDetailProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import Foundation

protocol EventDetailModuleInput {
	var moduleOutput: EventDetailModuleOutput? { get }
    var event: EventModel? {get set}
}

protocol EventDetailModuleOutput: AnyObject {
}

protocol EventDetailViewInput: AnyObject {
    func reloadData()
}

protocol EventDetailViewOutput: AnyObject {
    func viewDidLoad()
    func updateData()
    func getToken()
    func showAlertAuth()
}

protocol EventDetailInteractorInput: AnyObject {
    func reloadData()
    func getToken()
    func userAuth() -> Bool
}

protocol EventDetailInteractorOutput: AnyObject {
//    func receiveToken(token: Token?) MARK: Token Api get request
    func receiveData(event: EventModel)
}

protocol EventDetailRouterInput: AnyObject {
    func showAlertAuth(with view: EventDetailViewInput?)
}
