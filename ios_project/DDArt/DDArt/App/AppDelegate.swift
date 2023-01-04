//
//  AppDelegate.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !UserDefaults.standard.bool(forKey: "fistVisit") {
            self.window = UIWindow()
            let welcomeContainer = WelcomeContainer.assemble(with: WelcomeContext())
            self.window!.rootViewController = welcomeContainer.viewController
            self.window!.makeKeyAndVisible()
            UserDefaults.standard.set(true, forKey: "fistVisit")
            return true
        } else {
            let tabBarContainer = TabBarContainer.assemble(with: TabBarContext())
            self.window = UIWindow()
            self.window!.rootViewController = tabBarContainer.viewController
            self.window!.makeKeyAndVisible()
            self.window!.backgroundColor = .red
            return true
        }
    }
    
}
