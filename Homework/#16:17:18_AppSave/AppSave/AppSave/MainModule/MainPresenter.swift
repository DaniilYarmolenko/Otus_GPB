//
//  MainPresenter.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import Foundation

final class MainPresenter {
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?

	private let router: MainRouterInput
	private let interactor: MainInteractorInput
    var model: ImageApiModel?
    var image: Data?
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainModuleInput {
    var modelInput: ImageApiModel? {
        get {
            return model
        }
        set {
            model = newValue
            guard let resourceURL = URL(string: newValue?.first?.url ?? " ") else {
                return
            }
            ImageLoader.shared.getData(from: resourceURL) { data, _, _ in
                DispatchQueue.main.async {
                    self.image = data ?? Data()
                }
            }
        }
    }
    
}

extension MainPresenter: MainViewOutput {
    func inCoreData(name: String) -> Bool {
        interactor.inCoreData(name: name)
    }
    
    func inCacheData(name: String) -> Bool {
        interactor.inCacheData(name: name)
    }
    
    func getData() {
        interactor.loadData()
    }
    
    func addToCoreData(name: String, selected: Bool) {
        guard let image = image else {
            return}
        let model = ImageSaveModel(id: self.model?.first?.id ?? "", url: self.model?.first?.url ?? "", data: image, name: name)
        interactor.addToCoreData(model: model, selected: selected)
    }
    
    func addToCache(name: String, selected: Bool) {
        guard let image = image else {return}
        let model = ImageSaveModel(id: self.model?.first?.id ?? "", url: self.model?.first?.url ?? "", data: image, name: name)
        interactor.addToCache(model: model, selected: selected)
    }
    
    
}

extension MainPresenter: MainInteractorOutput {
    func receiveModel(model: ImageApiModel) {
        modelInput = model
        view?.reloadImage(model: model)
    }
    

}
