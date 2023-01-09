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
            OnboardingViewController(imageName: "ddLarge", titleText: "Мероприятия в DDSpace", subtitleText: "Узнавай о мероприятиях и акциях в DD Space первым, с помощью приложения"),
            OnboardingViewController(imageName: "waiter", titleText: "Заказ еды онлайн", subtitleText: "Не надо больше ждать официанта. Выбери столик, закажи и оплати онлайн, а официант принесет заказ"),
            OnboardingViewController(imageName: "registr", titleText: "Регистрация в приложении", subtitleText: "Регистрируйся на мероприятия онлайн в приложении и получай QR-Code"),
            SigninContainer.assemble(with: SigninContext()).viewController
        ]
        return views
    }
}
