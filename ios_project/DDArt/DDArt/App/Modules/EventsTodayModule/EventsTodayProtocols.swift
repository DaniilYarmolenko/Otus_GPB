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
}

protocol EventsTodayViewInput: AnyObject {
}

protocol EventsTodayViewOutput: AnyObject {
}

protocol EventsTodayInteractorInput: AnyObject {
}

protocol EventsTodayInteractorOutput: AnyObject {
}

protocol EventsTodayRouterInput: AnyObject {
}
