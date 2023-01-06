//
//  FoodCartProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol FoodCartModuleInput {
	var moduleOutput: FoodCartModuleOutput? { get }
}

protocol FoodCartModuleOutput: AnyObject {
}

protocol FoodCartViewInput: AnyObject {
}

protocol FoodCartViewOutput: AnyObject {
}

protocol FoodCartInteractorInput: AnyObject {
}

protocol FoodCartInteractorOutput: AnyObject {
}

protocol FoodCartRouterInput: AnyObject {
}
