//
//  TabBarProtocols.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
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
    func getModel(at index: Int) -> TabBarItem
}

protocol TabBarInteractorInput: AnyObject {
    func getTabBarItemsInfo()
}

protocol TabBarInteractorOutput: AnyObject {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItem])
}

protocol TabBarRouterInput: AnyObject {
    func getViews() -> [UIViewController]
}

