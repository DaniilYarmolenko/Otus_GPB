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
        Coordinator(window: window).start()
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataService.shared.deleteAll()
        UserDefaults.standard.setValue(0, forKey: "countCart")
    }
}
