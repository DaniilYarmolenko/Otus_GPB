//
//  ColorsMockData.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation

struct MockColorsData {
    static func sampleDataColor() -> [ColorModel] {
        return [
            ColorModel(red: 1.0, green: 0.0, blue: 0.0, colorType: .red),
            ColorModel(red: 0.0, green: 1.0, blue: 0.0, colorType: .green),
            ColorModel(red: 0.0, green: 0.0, blue: 1.0, colorType: .blue)
        ]
    }
}
