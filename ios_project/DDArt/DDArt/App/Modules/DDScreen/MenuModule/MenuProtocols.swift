//
//  MenuProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import Foundation

protocol MenuModuleInput {
	var moduleOutput: MenuModuleOutput? { get }
}

protocol MenuModuleOutput: AnyObject {
}

protocol MenuViewInput: AnyObject {
}

protocol MenuViewOutput: AnyObject {
}

protocol MenuInteractorInput: AnyObject {
}

protocol MenuInteractorOutput: AnyObject {
}

protocol MenuRouterInput: AnyObject {
}
