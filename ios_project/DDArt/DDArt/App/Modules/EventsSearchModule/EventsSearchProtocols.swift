//
//  EventsSearchProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol EventsSearchModuleInput {
	var moduleOutput: EventsSearchModuleOutput? { get }
}

protocol EventsSearchModuleOutput: AnyObject {
}

protocol EventsSearchViewInput: AnyObject {
}

protocol EventsSearchViewOutput: AnyObject {
}

protocol EventsSearchInteractorInput: AnyObject {
}

protocol EventsSearchInteractorOutput: AnyObject {
}

protocol EventsSearchRouterInput: AnyObject {
}
