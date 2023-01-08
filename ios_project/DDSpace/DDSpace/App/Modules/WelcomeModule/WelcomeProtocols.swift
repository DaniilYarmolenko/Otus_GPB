//
//  WelcomeProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import Foundation
import  UIKit

protocol WelcomeModuleInput {
	var moduleOutput: WelcomeModuleOutput? { get }
}

protocol WelcomeModuleOutput: AnyObject {
}

protocol WelcomeViewInput: AnyObject {
    func receiveViews(with views: [UIViewController])
}

protocol WelcomeViewOutput: AnyObject {
    func viewDidLoad()
    func getViews()
}

protocol WelcomeInteractorInput: AnyObject {
}

protocol WelcomeInteractorOutput: AnyObject {
}

protocol WelcomeRouterInput: AnyObject {
    func receiveViews() -> [UIViewController]
}
