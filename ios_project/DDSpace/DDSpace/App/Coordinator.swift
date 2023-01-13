//
//  Coordinator.swift
//  DDSpace
//
//  Created by Даниил Ярмоленко on 11.01.2023.
//

import Foundation
import UIKit

protocol AppCoordinator {
    var window: UIWindow? {get set}
    func start()
}

class Coordinator: AppCoordinator {
    weak var window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    func start() {
        if !UserDefaults.standard.bool(forKey: "firstVisit") {
            let welcomeContainer = WelcomeContainer.assemble(with: WelcomeContext())
            self.window?.rootViewController = welcomeContainer.viewController
            UserDefaults.standard.set(true, forKey: "firstVisit")
        } else if Auth().token == nil {
            let signInContainer = SigninContainer.assemble(with: SigninContext())
            self.window?.rootViewController = signInContainer.viewController
        } else {
            let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
            self.window?.rootViewController = tabBarContainer.viewController
        }
    }
}
