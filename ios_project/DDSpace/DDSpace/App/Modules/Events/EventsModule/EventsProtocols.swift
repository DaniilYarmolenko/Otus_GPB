//
//  EventsProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

protocol EventsModuleInput {
    var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: AnyObject {
}

protocol EventsViewInput: AnyObject {
    func receiveViews(with views: [UIViewController])
}

protocol EventsViewOutput: AnyObject {
    func viewDidLoad()
    func getViews()
}

protocol EventsInteractorInput: AnyObject {
    func loadData()
}

protocol EventsInteractorOutput: AnyObject {
    func receiveDataSegment(allEvent: [EventModel], category: [CategoryModel])
    func didFail(message: String)
}
protocol EventsRouterInput: AnyObject {
}
