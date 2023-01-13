//
//  EventDetailProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import Foundation
import UIKit

protocol EventDetailModuleInput {
    var moduleOutput: EventDetailModuleOutput? { get }
    var event: EventModel? {get set}
}

protocol EventDetailModuleOutput: AnyObject {
}

protocol EventDetailViewInput: AnyObject {
    func loadData(model: EventModel, imageToken: UIImage?)
}

protocol EventDetailViewOutput: AnyObject {
    func viewDidLoad()
    func updateData()
    func getToken()
    func tapOnRegister()
}

protocol EventDetailInteractorInput: AnyObject {
    func reloadData()
    func getToken()
    func userAuth() -> Bool
}

protocol EventDetailInteractorOutput: AnyObject {
    func receiveData(event: EventModel)
}

protocol EventDetailRouterInput: AnyObject {
    func showAlertAuth(with view: EventDetailViewInput?)
    func showOpsAlert(with view: EventDetailViewInput?)
}
