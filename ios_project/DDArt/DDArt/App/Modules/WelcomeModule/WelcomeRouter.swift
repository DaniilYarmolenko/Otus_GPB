//
//  WelcomeRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import UIKit

final class WelcomeRouter {
}

extension WelcomeRouter: WelcomeRouterInput {
    
    func receiveViews() -> [UIViewController] {
        let views = [
            OnboardingViewController(imageName: "", titleText: "First", subtitleText: "FirstMini"),
            OnboardingViewController(imageName: "", titleText: "Second", subtitleText: "SecondMini"),
            OnboardingViewController(imageName: "", titleText: "Third", subtitleText: "ThirdMini"),
            OnboardingViewController(imageName: "", titleText: "Fore", subtitleText: "ForeMini"),
            SigninContainer.assemble(with: SigninContext()).viewController
        ]
        return views
    }
}
