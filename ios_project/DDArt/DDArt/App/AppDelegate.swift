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
        self.window = UIWindow()
        if !UserDefaults.standard.bool(forKey: "firstVisit") {
            let welcomeContainer = WelcomeContainer.assemble(with: WelcomeContext())
            self.window!.rootViewController = welcomeContainer.viewController
            self.window!.makeKeyAndVisible()
            UserDefaults.standard.set(true, forKey: "firstVisit")
            return true
        } else if Auth().token == nil {

            let signInContainer = SigninContainer.assemble(with: SigninContext())
            self.window?.rootViewController = signInContainer.viewController
            self.window?.makeKeyAndVisible()
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
