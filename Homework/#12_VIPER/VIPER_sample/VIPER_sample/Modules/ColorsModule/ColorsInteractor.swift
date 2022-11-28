//
//  ColorsInteractor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class ColorsInteractor {
	weak var output: ColorsInteractorOutput?
    private var array = [ColorModel]()
    private var colorServiceManager: ColorMockService?
    
    init() {
        self.colorServiceManager = ColorMockService(output: self)
    }
}


extension ColorsInteractor: ColorsInteractorInput {
    func loadData() {
        colorServiceManager?.requestToMockService()
    }
    
    func receiveData(index: Int) -> ColorModel {
       return array[index]
    }
    
}
extension ColorsInteractor: ColorsMockOutput {
    func receiveFromMock<T>(data: [T]) {
        guard let data = data as? [ColorModel] else { return }
        array = data
        output?.receiveData(data: data)
    }
    
    
}
