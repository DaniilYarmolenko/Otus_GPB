//
//  ExtraScreenProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

protocol ExtraScreenModuleInput {
	var moduleOutput: ExtraScreenModuleOutput? { get }
}

protocol ExtraScreenModuleOutput: AnyObject {
}

protocol ExtraScreenViewInput: AnyObject {
}

protocol ExtraScreenViewOutput: AnyObject {
}

protocol ExtraScreenInteractorInput: AnyObject {
}

protocol ExtraScreenInteractorOutput: AnyObject {
}

protocol ExtraScreenRouterInput: AnyObject {
}
