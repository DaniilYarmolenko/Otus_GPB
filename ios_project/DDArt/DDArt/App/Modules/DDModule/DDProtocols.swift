//
//  DDProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol DDModuleInput {
	var moduleOutput: DDModuleOutput? { get }
}

protocol DDModuleOutput: AnyObject {
}

protocol DDViewInput: AnyObject {
}

protocol DDViewOutput: AnyObject {
}

protocol DDInteractorInput: AnyObject {
}

protocol DDInteractorOutput: AnyObject {
}

protocol DDRouterInput: AnyObject {
}
