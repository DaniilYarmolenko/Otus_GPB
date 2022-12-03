//
//  AppDelegate.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
        self.window = UIWindow()
        self.window!.rootViewController = tabBarContainer.viewController
        self.window!.makeKeyAndVisible()
        return true
    }


}

