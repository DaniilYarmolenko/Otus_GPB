//
//  FoodDetailProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol FoodDetailModuleInput {
	var moduleOutput: FoodDetailModuleOutput? { get }
}

protocol FoodDetailModuleOutput: AnyObject {
}

protocol FoodDetailViewInput: AnyObject {
}

protocol FoodDetailViewOutput: AnyObject {
}

protocol FoodDetailInteractorInput: AnyObject {
}

protocol FoodDetailInteractorOutput: AnyObject {
}

protocol FoodDetailRouterInput: AnyObject {
}
