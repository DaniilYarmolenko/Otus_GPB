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
}

protocol EventsFutureViewInput: AnyObject {
}

protocol EventsFutureViewOutput: AnyObject {
}

protocol EventsFutureInteractorInput: AnyObject {
}

protocol EventsFutureInteractorOutput: AnyObject {
}

protocol EventsFutureRouterInput: AnyObject {
}
