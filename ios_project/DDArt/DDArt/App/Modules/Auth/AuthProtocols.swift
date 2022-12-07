//
//  AuthProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

protocol AuthModuleInput {
	var moduleOutput: AuthModuleOutput? { get }
}

protocol AuthModuleOutput: AnyObject {
}

protocol AuthViewInput: AnyObject {
}

protocol AuthViewOutput: AnyObject {
}

protocol AuthInteractorInput: AnyObject {
}

protocol AuthInteractorOutput: AnyObject {
}

protocol AuthRouterInput: AnyObject {
}
