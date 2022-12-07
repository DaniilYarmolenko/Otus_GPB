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
    func getData()
}

protocol EventsInteractorOutput: AnyObject {
    func receiveViewSegment(model: String, index: Int)
}

protocol EventsRouterInput: AnyObject {
    func getViews() -> [UIViewController]
}
