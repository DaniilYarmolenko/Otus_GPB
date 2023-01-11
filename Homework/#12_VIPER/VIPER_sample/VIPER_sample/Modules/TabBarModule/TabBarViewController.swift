//
//  TabBarViewController.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
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
        self.tabBar.backgroundColor = .black
    }
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name("cart"), object: nil)
    }
    
    @objc
    private func notificationAction() {
        let count = UserDefaults.standard.integer(forKey: "cart_count")
        if count != 0 {
            self.viewControllers?.last?.tabBarItem.badgeValue = "\(count)"
        } else {
            self.viewControllers?.last?.tabBarItem.badgeValue = nil
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
