//
//  ColorDetailInteractor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import Foundation

final class ColorDetailInteractor {
	weak var output: ColorDetailInteractorOutput?
    private var array = [ColorDetailModel]()
}

extension ColorDetailInteractor: ColorDetailInteractorInput {
    func receiveData(index: Int) -> ColorDetailModel {
        array[index]
    }
    
    func loadData(colorType: Color) {
        array = ColorDetailData(color: colorType).sampleDataColor()
        output?.receiveData(data: array)
    }
    
}
