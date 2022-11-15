//
//  ExtraScreenPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class ExtraScreenPresenter {
	weak var view: ExtraScreenViewInput?
    weak var moduleOutput: ExtraScreenModuleOutput?

	private let router: ExtraScreenRouterInput
	private let interactor: ExtraScreenInteractorInput

    init(router: ExtraScreenRouterInput, interactor: ExtraScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ExtraScreenPresenter: ExtraScreenModuleInput {
}

extension ExtraScreenPresenter: ExtraScreenViewOutput {
}

extension ExtraScreenPresenter: ExtraScreenInteractorOutput {
}
