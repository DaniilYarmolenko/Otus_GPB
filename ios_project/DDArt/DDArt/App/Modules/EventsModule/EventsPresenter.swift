//
//  EventsPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class EventsPresenter {
	weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    var model: String = ""
    
	private let router: EventsRouterInput
	private let interactor: EventsInteractorInput

    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    
    func viewDidLoad() {
        getViews()
    }
    func getViews(){
        let views = self.router.getViews()
        self.view?.receiveViews(with: views)
    }
}
extension EventsPresenter: EventsInteractorOutput {
    func receiveViewSegment(model: String, index: Int) {
    }
    
}
