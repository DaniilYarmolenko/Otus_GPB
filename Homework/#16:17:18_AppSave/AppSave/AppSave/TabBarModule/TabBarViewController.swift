//
//  TabBarViewController.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class TabBarViewController: UITabBarController {
	private let output: TabBarViewOutput

    init(output: TabBarViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setUp()
        setUpNotification()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.getViews()
    }
    private func setUp() {
        self.tabBar.tintColor = .orange
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
    }
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationActionCoreData), name: NSNotification.Name("coreData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationActionCacheData), name: NSNotification.Name("cacheData"), object: nil)
    }
    
    @objc
    private func notificationActionCoreData() {
        let countCoreData = UserDefaults.standard.integer(forKey: "countCoreData")
        
        if countCoreData != 0 {
            self.viewControllers?[1].tabBarItem.badgeValue = "\(countCoreData)"
        } else {
            self.viewControllers?[1].tabBarItem.badgeValue = nil
        }
    }
    @objc
    private func notificationActionCacheData() {
        let countCacheData = UserDefaults.standard.stringArray(forKey: "urls")?.count
        if countCacheData != 0 && countCacheData != nil {
            self.viewControllers?[2].tabBarItem.badgeValue = "\(countCacheData!)"
        } else {
            self.viewControllers?[2].tabBarItem.badgeValue = nil
        }
    }
}

extension TabBarViewController: TabBarViewInput {
    func getImageFromString(withName name: String) -> UIImage? {
        UIImage(named: name)
    }
    func receiveViews(with views: [UIViewController]) {
        for i in 0..<views.count {
            let model = output.getModel(at: i)
            let icon = UITabBarItem(title: model.title, image: getImageFromString(withName: model.image), selectedImage: getImageFromString(withName: model.selectedImage))
            views[i].tabBarItem = icon
            self.viewControllers = views.map {
                let nv = UINavigationController(rootViewController: $0)
                return nv
            }
        }
    }
}
