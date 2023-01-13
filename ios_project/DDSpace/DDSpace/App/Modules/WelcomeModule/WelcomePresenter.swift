//
//  WelcomePresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import Foundation

final class WelcomePresenter {
    weak var view: WelcomeViewInput?
    weak var moduleOutput: WelcomeModuleOutput?
    
    private let router: WelcomeRouterInput
    private let interactor: WelcomeInteractorInput
    
    
    init(router: WelcomeRouterInput, interactor: WelcomeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WelcomePresenter: WelcomeModuleInput {
}

extension WelcomePresenter: WelcomeViewOutput {    
    func getViews() {
        let views = router.receiveViews()
        self.view?.receiveViews(with: views)
    }
    
}

extension WelcomePresenter: WelcomeInteractorOutput {
}
