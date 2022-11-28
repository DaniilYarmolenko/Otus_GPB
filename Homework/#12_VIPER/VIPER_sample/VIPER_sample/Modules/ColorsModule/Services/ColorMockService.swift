//
//  ColorMockService.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation

final class ColorMockService: ColorsMockInput {
    weak var output: ColorsMockOutput?
    init(output: ColorsMockOutput?) {
        self.output = output
    }
    func requestToMockService() {
        let data = MockColorsData.sampleDataColor()
        self.output?.receiveFromMock(data: data)
    }
}
