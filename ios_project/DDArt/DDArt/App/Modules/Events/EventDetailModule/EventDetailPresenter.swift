//
//  EventDetailPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import Foundation
import UIKit
final class EventDetailPresenter {
	weak var view: EventDetailViewInput?
    weak var moduleOutput: EventDetailModuleOutput?
    var eventDetail: EventModel?
	private let router: EventDetailRouterInput
	private let interactor: EventDetailInteractorInput

    init(router: EventDetailRouterInput, interactor: EventDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventDetailPresenter: EventDetailModuleInput {
    var event: EventModel? {
        get {
            eventDetail
        }
        set {
            eventDetail = newValue
        }
    }
    
}

extension EventDetailPresenter: EventDetailViewOutput {
    func viewDidLoad() {
        if let event = eventDetail {
            receiveData(event: event)
        }
    }
    
    func updateData() {
        interactor.reloadData()
    }
    
    func getToken() {
        
        guard interactor.userAuth() else {
            interactor.getToken()
            return
        }
        showAlertAuth()
    }
    func showAlertAuth() {
        router.showAlertAuth(with: view)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
}

extension EventDetailPresenter: EventDetailInteractorOutput {
    func receiveData(event: EventModel) {
        eventDetail = event
        view?.loadData(model: event, imageToken: nil)
    }
    
}
