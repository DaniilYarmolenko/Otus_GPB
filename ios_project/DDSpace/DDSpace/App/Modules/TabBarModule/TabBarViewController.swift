//
//  TabBarViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
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
    }
    
    private func setUp() {
        self.tabBar.tintColor = ColorConstants.TintColor
        self.tabBar.unselectedItemTintColor = ColorConstants.LightGrey
        self.tabBar.barTintColor = ColorConstants.TabBarColor
        self.tabBar.backgroundColor = ColorConstants.TabBarColor
        self.tabBar.layer.borderColor = UIColor.black.cgColor
        self.tabBar.layer.borderWidth = 0.5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        output.getViews()
    }
    func getImageFromString(withName name: String) -> UIImage? {
        UIImage(named: name)
    }
}

extension TabBarViewController: TabBarViewInput {
    func receiveViews(with views: [UIViewController], tabBar: [TabBarItemModel]) {
        for i in 0..<views.count {
            let model = tabBar[i]
            let icon = UITabBarItem(title: model.title, image: getImageFromString(withName: model.image), selectedImage: getImageFromString(withName: model.selectedImage))
            views[i].tabBarItem = icon
            self.viewControllers = views.map {
                let nv = UINavigationController(rootViewController: $0)
                return nv
            }
        }
    }
    
}
