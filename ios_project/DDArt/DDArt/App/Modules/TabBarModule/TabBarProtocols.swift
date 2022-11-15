//
//  TabBarProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation
import UIKit

protocol TabBarModuleInput {
	var moduleOutput: TabBarModuleOutput? { get }
}

protocol TabBarModuleOutput: AnyObject {
}

protocol TabBarViewInput: AnyObject {
    func receiveViews(with views: [UIViewController])
}

protocol TabBarViewOutput: AnyObject {
    func getViews()
    func getModel(at index: Int) -> TabBarItemModel
}

protocol TabBarInteractorInput: AnyObject {
    func getTabBarItemsInfo()
}

protocol TabBarInteractorOutput: AnyObject {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItemModel])
}

protocol TabBarRouterInput: AnyObject {
    func getViews() -> [UIViewController]
}
