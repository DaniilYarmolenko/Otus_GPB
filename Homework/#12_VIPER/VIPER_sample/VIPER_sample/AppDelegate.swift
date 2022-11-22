//
//  AppDelegate.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
        self.window = UIWindow()
        self.window!.rootViewController = tabBarContainer.viewController
        self.window!.makeKeyAndVisible()
        self.window!.backgroundColor = .red
        return true
    }


}

